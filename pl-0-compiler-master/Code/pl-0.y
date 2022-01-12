%token t_punkt t_plus t_minus t_mal t_div t_kla_auf t_kla_zu t_ungleich
     t_zuweisung t_kleiner_gleich t_kleiner t_groesser_gleich t_groesser
     t_gleich t_komma t_semikolon t_eingabe t_ausgabe t_const t_var
     t_procedure t_call t_begin t_end t_if t_then t_while t_do t_odd
     t_number t_ident t_fehler t_debug
%union {char txt[20];} //Nur fuer Kompatibilitaet!!!
%type <txt> t_ident t_number
%{
    void yyerror(const char * t);
    #include "lex.yy.hpp"
    #include "pl0-symtab.hpp"
    #include "pl0-zwischencode.hpp"
    #include "pl0-codeerzeugung.hpp"
    #include <iostream>
    #include <vector>
    #include <stack>
    #include <memory>
    #include <string>
    symtab st;
    zwischencode zc;
    operatorbaum o;
    codeerzeugung ce;
    int procNr = 0;
    ast_stmt * old = NULL;
    stack<op_tree*> op_stack;
%}
%%
program:        {zc.new_ast_layer("main");}
                block t_punkt
                {
                        
                        vector<ast_entry> _ast = zc.get_ast();
                        // CODEERZEUGUNG AUFRUFEN
                        ce.generate(_ast);
                }; 

block:          {st.level_up();}
                A B C statement
                {
                        st.level_down();

                        zc.new_End_Node();
                };

A:              t_const t_ident t_gleich t_number
                {
                        int returnV = st.insert($2, st_const);
                        if(returnV != 0) return 1;
                        int stl, varnr;
                        returnV = st.lookup($2, st_const, &stl, &varnr);
                        if(returnV != 0) return 1;
                        string id = "Number " + to_string(atoi($4));
                        zc.new_Assign_Node($2, o.new_op_tree(o.new_op_entry(t_number, id, -1, atoi($4))), stl, varnr);
                        zc.add_Var();
                }
                D t_semikolon
        |       /*Epsilon*/;

B:              t_var t_ident
                {
                        int returnV = st.insert($2, st_var);
                        if(returnV != 0) return 1;
                        zc.add_Var();
                }
                E t_semikolon
        |       /*Epsilon*/;

C:              t_procedure t_ident 
                {
                        procNr++;
                        int returnV = st.insert($2, st_proc, procNr);
                        if(returnV != 0) return 1;
                        zc.new_ast_layer($2);
                }
                t_semikolon block t_semikolon C
        |       /*Epsilon*/;

D:              t_komma t_ident t_gleich t_number
                {
                        int returnV = st.insert($2, st_const);
                        if(returnV != 0) return 1;
                        int stl, varnr;
                        returnV = st.lookup($2, st_const, &stl, &varnr);
                        if(returnV != 0) return 1;
                        string id = "Number " + to_string(atoi($4));
                        zc.new_Assign_Node($2, o.new_op_tree(o.new_op_entry(t_number, id, -1, atoi($4))), stl, varnr);
                        zc.add_Var();
                }
                D
        |       /*Epsilon*/;

E:              t_komma t_ident
                {
                        int returnV = st.insert($2, st_var);
                        if(returnV != 0) return 1;
                        zc.add_Var();
                }
                E
        |       /*Epsilon*/;

statement:      t_ident t_zuweisung expression
                {
                        int stl, varnr;
                        int returnV = st.lookup($1, st_var, &stl, &varnr);
                        if(returnV != 0) return 1;
                        zc.new_Assign_Node($1, op_stack.top(), stl, varnr);
                        op_stack.pop();
                }
        |       t_call t_ident
                {
                        int stl, varnr;
                        int returnV = st.lookup($2, st_proc, &stl, &varnr);
                        if(returnV != 0) return 1;
                        zc.new_Call_Node($2, stl, varnr);

                }
        |       t_eingabe t_ident
                {
                        int stl, varnr;
                        int returnV = st.lookup($2, st_var, &stl, &varnr);
                        if(returnV != 0) return 1;
                        zc.new_Eingabe_Node($2, stl, varnr);
                }
        |       t_ausgabe expression
                {
                        zc.new_Ausgabe_Node(op_stack.top());
                        op_stack.pop();
                }
        |       t_begin statement F t_end
        |       t_if condition 
                {
                        zc.new_If_Stmt(op_stack.top());
                        op_stack.pop();
                }
                t_then statement
                {
                        zc.end_If();
                }
        |       t_while condition 
                {
                        zc.new_While_Stmt(op_stack.top());
                        op_stack.pop();
                }
                t_do statement
                {
                        zc.end_While();
                }
        |       t_debug
                {
                        st.print();
                        zc.print();
                }
        |       /*Epsilon*/;

F:              t_semikolon statement F
        |       /*Epsilon*/;

condition:      t_odd expression
                {
                        op_tree * dummy = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_odd, "ODD"), dummy));
                }
        |       expression t_gleich expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_gleich, "GLEICH"), dummyl, dummyr));
                }
        |       expression t_ungleich expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_ungleich, "UNGLEICH"), dummyl, dummyr));
                }
        |       expression t_kleiner expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_kleiner, "KLEINER"), dummyl, dummyr));
                }
        |       expression t_kleiner_gleich expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_kleiner_gleich, "KLEINER GLEICH"), dummyl, dummyr));
                }
        |       expression t_groesser expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_groesser, "GROESSER"), dummyl, dummyr));
                }
        |       expression t_groesser_gleich expression
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_groesser_gleich, "GREOSSER GLEICH"), dummyl, dummyr));
                };

expression:     t_plus term I 
        |       t_minus term 
                {
                        op_tree * dummy = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_minus, "CHS"), dummy)); 
                }I
        |       term I;

I:              t_plus term 
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_plus, "PLUS"), dummyl, dummyr));
                }
                I
        |       t_minus term 
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_minus, "MINUS"), dummyl, dummyr));
                }
                I
        |       /*Epsilon*/;


term:           factor K;

K:              t_mal factor 
                { 
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_mal, "MAL"), dummyl, dummyr));
                }
                K
        |       t_div factor 
                {
                        op_tree * dummyr = op_stack.top();
                        op_stack.pop();
                        op_tree * dummyl = op_stack.top();
                        op_stack.pop();
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_div, "GETEILT"), dummyl, dummyr));
                } K
        |       /*Epsilon*/;


factor:         t_ident
                {
                        int stl, varnr;
                        int returnV = st.lookup($1, st_var|st_const, &stl, &varnr);
                        if(returnV != 0) return 1;
                        string var($1);
                        string id = "Identifier " + var;
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_ident, id, stl, varnr)));
                }
        |       t_number
                {
                        string id = "Number " + to_string(atoi($1));
                        op_stack.push(o.new_op_tree(o.new_op_entry(t_number, id, -1, atoi($1))));
                }
        |       t_kla_auf expression t_kla_zu;
%%