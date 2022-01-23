%token t_CONST 
       t_VAR           
       t_PROCEDURE     
       t_CALL          
       t_BEGIN         
       t_END    
       t_IF 
       t_THEN     
       t_WHILE   
       t_DO       
       t_ODD   
       t_DEBUG   
       t_Q_MARK         "?" 
       t_E_MARK         "!"
       t_DOT            "."
       t_EQUAL          "="
       t_COMMA          ","
       t_SEMICOLON      ";"
       t_ASSIGNMENT     ":="
       t_N_EQUAL        "#"
       t_LT             "<"
       t_LTE            "<="
       t_GT             ">"
       t_GTE            ">="
       t_PLUS           "+"
       t_MINUS          "-"
       t_MULT           "*"
       t_DIV            "/"
       t_OPEN_BRACK     "("
       t_CLOSE_BRACK    ")"

%union {char txt[20];}

%token<txt> t_IDENT t_NUMBER
%{
    void yyerror(const char *t);
    #include <iostream>
    #include <vector>
    #include <string>
    #include <stack>
    #include "lex.yy.hpp"
    #include "pl0_symtab.hpp"
    #include "pl0_codegeneration.hpp"

    tree T;
    optree op;
    symtab st;
    codegeneration c;
    int procNr = 1, varCount = 0;
    stack<op_tree*> op_stack;
%}

%%
program:        {
                    T.new_ast_level("main");
                }
                block "."
                {
                    vector<ast_entry> ast = T.get_ast_list();
                    c.generate(ast);
                }
                ;

block:          {
                    st.level_up();
                    varCount = 0;
                }
                constDec varDec procDec statement
                {
                    st.level_down();
                    T.new_end();
                }
                ;

constDec:       t_CONST constList ";" 
                | /* epsilon */
                ;

constList:      t_IDENT "=" t_NUMBER 
                {
                    int returnValue = st.insert($1, st_const, varCount++);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($1, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                    T.new_assign($1, op.new_op_tree(op.new_ast_expr(t_NUMBER, "NUMBER " + to_string(atoi($3)), -1, atoi($3))), stl, varNr);
                    T.add_var();
                }
                | constList "," t_IDENT "=" t_NUMBER
                {
                    int returnValue = st.insert($3, st_const, varCount++);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($3, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                    T.new_assign($3, op.new_op_tree(op.new_ast_expr(t_NUMBER, "NUMBER " + to_string(atoi($5)), -1, atoi($5))), stl, varNr);
                    T.add_var();
                }
                ;

varDec:         t_VAR varList ";"
                | /* epsilon */
                ;

varList:        t_IDENT
                {
                    int returnValue = st.insert($1, st_var, varCount++);
                    if (returnValue != 0) return 1;
                    T.add_var();
                }
                | varList "," t_IDENT
                {
                    int returnValue = st.insert($3, st_var, varCount++);
                    if (returnValue != 0) return 1;
                    T.add_var();
                }
                ;

procDec:        t_PROCEDURE t_IDENT 
                {
                    int returnValue = st.insert($2, st_proc, procNr++);
                    if (returnValue != 0) return 1;
                    T.new_ast_level($2);
                }
                ";" block ";" procDec
                | /* epsilon */
                ;

statement:      t_IDENT ":=" expression
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                    T.new_assign($1, op_stack.top(), stl, varNr);
                    op_stack.pop();
                }
                | t_CALL t_IDENT
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_proc, stl, varNr);
                    if (returnValue != 0) return 1;
                    T.new_call($2, stl, varNr);
                }
                | "?" t_IDENT
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                    T.new_read($2, stl, varNr);
                }
                | "!" expression
                {
                    T.new_write(op_stack.top());
                    op_stack.pop();
                }
                | t_BEGIN statementList t_END
                | t_IF condition 
                {
                    T.new_if(op_stack.top());
                    op_stack.pop();
                }
                t_THEN statement
                {
                    T.end_if();
                }
                | t_WHILE condition 
                {
                    T.new_while(op_stack.top());
                    op_stack.pop();
                }
                t_DO statement
                {
                    T.end_while();
                }
                | t_DEBUG
                {
                    st.print();
                    T.print();
                }
                | /* epsilon */
                ;

statementList:  statement
                | statementList ";" statement
                ;

condition:      t_ODD expression
                {
                    op_tree * tos = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_ODD, "ODD"), tos));
                }
                | expression "#" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_N_EQUAL, "NOT_EQUAL"), tosLeft, tosRight));
                }
                | expression "=" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_EQUAL, "EQUAL"), tosLeft, tosRight));
                }
                | expression "<" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_LT, "LESS_THEN"), tosLeft, tosRight));
                }
                | expression "<=" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_LTE, "LESS_THEN_EQUAL"), tosLeft, tosRight));
                }
                | expression ">" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_GT, "GREATER_THEN"), tosLeft, tosRight));
                }
                | expression ">=" expression
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_GTE, "GREATE_THEN_EQUAL"), tosLeft, tosRight));
                }
                ;

expression:     term
                | "-" term
                {
                    op_tree * tos = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MINUS, "CHS"), tos));
                }
                | expression "+" term
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_PLUS, "PLUS"), tosLeft, tosRight));
                }
                | expression "-" term
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MINUS, "MINUS"), tosLeft, tosRight));
                }
                ;

term:           factor
                | term "*" factor
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MULT, "MULT"), tosLeft, tosRight));
                }
                | term "/" factor
                {
                    op_tree * tosRight = op_stack.top();
                    op_stack.pop();
                    op_tree * tosLeft = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_DIV, "DIV"), tosLeft, tosRight));
                }
                ;
factor:         t_IDENT
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var|st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                    string var($1);
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_IDENT, "ID " + var, stl, varNr)));
                }
                | t_NUMBER
                {
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_NUMBER, "NUMBER " + to_string(atoi($1)), -1, atoi($1))));
                }
                | "(" expression ")"
                ;
%%