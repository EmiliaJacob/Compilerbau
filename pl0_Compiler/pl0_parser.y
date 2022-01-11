%token t_const         t_var            t_procedure     t_call          t_begin         
        t_end           t_if            t_then          t_while         t_do            
        t_odd           t_q_mark        t_e_mark        t_dot           t_equal         
        t_comma         t_semicolon     t_assignment    t_hashtag       t_lt            
        t_lte           t_gt            t_gte           t_plus          t_minus         
        t_mult          t_div           t_open_brack    t_close_brack   t_error
        t_debug
%union {char txt[20];}
%token<txt> t_ident t_number
%{
    void yyerror(const char *t);
    #include "lex.yy.hpp"
    #include "pl0-symtab.hpp"

    symtab st;
    int procNr = 0, varCount = 0;
%}
%%
program:        block t_dot
                ;

block:          {
                    st.level_up();
                }
                constDec varDec procDec statement
                {st.level_down();}
                ;

constDec:       t_const constList t_semicolon 
                | /* epsilon */
                ;

constList:      t_ident t_equal t_number 
                {
                    varCount++;
                    int returnValue = st.insert($1, st_const, varCount);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($1, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | constList t_comma t_ident t_equal t_number
                {
                    varCount++;
                    int returnValue = st.insert($3, st_const, varCount);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($3, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                ;

varDec:         t_var varList t_semicolon
                | /* epsilon */
                ;

varList:        t_ident
                {
                    varCount++;
                    int returnValue = st.insert($1, st_var, varCount);
                    if (returnValue != 0) return 1;
                }
                | varList t_comma t_ident
                {
                    varCount++;
                    int returnValue = st.insert($3, st_var, varCount);
                    if (returnValue != 0) return 1;
                }
                ;

procDec:        t_procedure t_ident 
                {
                    procNr++;
                    int returnValue = st.insert($2, st_proc, procNr);
                    if (returnValue != 0) return 1;
                }
                t_semicolon block t_semicolon procDec
                | /* epsilon */
                ;

statement:      t_ident t_assignment expression
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | t_call t_ident
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_proc, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | t_q_mark t_ident
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | t_e_mark expression
                | t_begin statementList t_end
                | t_if condition t_then statement
                | t_while condition t_do statement
                | t_debug
                | /* epsilon */
                ;

statementList:  statement
                | statementList t_semicolon statement
                ;

condition:      t_odd expression
                | expression operator expression
                ;

operator:       t_hashtag 
                | t_equal 
                | t_lt 
                | t_lte 
                | t_gt 
                | t_gte
                ;

expression:     term
                | addSubSign term
                | expression addSubSign term
                ;

addSubSign:     t_plus
                | t_minus
                ;

term:           factor
                | term multDivSign factor
                ;

multDivSign:    t_mult
                | t_div
                ;

factor:         t_ident
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var|st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | t_number
                | t_open_brack expression t_close_brack
                ;
%%