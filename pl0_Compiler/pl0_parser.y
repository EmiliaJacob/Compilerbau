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
    #include "pl0-symtab.hpp"
    #include "pl0_tree.hpp"

    void print_stack(stack<op_tree*> s) {
        stack<op_tree*> temp;
        while (s.empty() == false)
        {
            temp.push(s.top());
            s.pop();
        }  
    
        while (temp.empty() == false)
        {
            op_tree * t = temp.top();
            cout << t->entry.id << " ";
            temp.pop();
    
            // To restore contents of
            // the original stack.
            s.push(t); 
        }
    }

    tree T;
    optree op;
    symtab st;
    int procNr = 1, varCount = 0;
    stack<op_tree*> op_stack;
%}

%%
program:        {
                    T.new_ast_level("main");
                }
                block "."
                {
                    //
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
                    op_tree * dummy = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_ODD, "ODD"), dummy));
                }
                | expression "#" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_N_EQUAL, "NOT_EQUAL"), dummyL, dummyR));
                }
                | expression "=" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_EQUAL, "EQUAL"), dummyL, dummyR));
                }
                | expression "<" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_LT, "LESS_THEN"), dummyL, dummyR));
                }
                | expression "<=" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_LTE, "LESS_THEN_EQUAL"), dummyL, dummyR));
                }
                | expression ">" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_GT, "GREATER_THEN"), dummyL, dummyR));
                }
                | expression ">=" expression
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_GTE, "GREATE_THEN_EQUAL"), dummyL, dummyR));
                }
                ;

expression:     term
                | "-" term
                {
                    op_tree * dummy = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MINUS, "CHS"), dummy));
                }
                | expression "+" term
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_PLUS, "PLUS"), dummyL, dummyR));
                }
                | expression "-" term
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MINUS, "MINUS"), dummyL, dummyR));
                }
                ;

term:           factor
                | term "*" factor
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_MULT, "MULT"), dummyL, dummyR));
                }
                | term "/" factor
                {
                    op_tree * dummyR = op_stack.top();
                    op_stack.pop();
                    op_tree * dummyL = op_stack.top();
                    op_stack.pop();
                    op_stack.push(op.new_op_tree(op.new_ast_expr(t_DIV, "DIV"), dummyL, dummyR));
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