%token CONST 
       VAR           
       PROCEDURE     
       CALL          
       BEGIN         
       END    
       IF 
       THEN     
       WHILE   
       DO       
       ODD      
       Q_MARK       "?" 
       E_MARK        "!"
       DOT           "."
       EQUAL         "="
       COMMA         ","
       SEMICOLON     ";"
       ASSIGNMENT    ":="
       HASHTAG       "#"
       LT            "<"
       LTE           "<="
       GT           ">"
       GTE           ">="
       PLUS          "+"
       MINUS         "-"
       MULT          "*"
       DIV          "/" 
       OPEN_BRACKET    "("
       CLOSE_BRACKET   ")"
       ERROR 
       DEBUG 

%union {char txt[20];}

%token<txt> IDENTIFIER INTEGER
%{
    void yyerror(const char *t);
    #include "lex.yy.hpp"
    #include "pl0-symtab.hpp"

    symtab st;
    int procNr = 0, varCount = 0;
%}

%%
program:        block "."
                ;

block:          {
                    st.level_up();
                }
                constDec varDec procDec statement
                {st.level_down();}
                ;

constDec:       CONST constList ";" 
                | /* epsilon */
                ;

constList:      IDENTIFIER "=" INTEGER 
                {
                    varCount++;
                    int returnValue = st.insert($1, st_const, varCount);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($1, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | constList "," IDENTIFIER "=" INTEGER
                {
                    varCount++;
                    int returnValue = st.insert($3, st_const, varCount);
                    if (returnValue != 0) return 1;
                    int stl, varNr;
                    returnValue = st.lookup($3, st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                ;

varDec:         VAR varList ";"
                | /* epsilon */
                ;

varList:        IDENTIFIER
                {
                    varCount++;
                    int returnValue = st.insert($1, st_var, varCount);
                    if (returnValue != 0) return 1;
                }
                | varList "," IDENTIFIER
                {
                    varCount++;
                    int returnValue = st.insert($3, st_var, varCount);
                    if (returnValue != 0) return 1;
                }
                ;

procDec:        PROCEDURE IDENTIFIER 
                {
                    procNr++;
                    int returnValue = st.insert($2, st_proc, procNr);
                    if (returnValue != 0) return 1;
                }
                ";" block ";" procDec
                | /* epsilon */
                ;

statement:      IDENTIFIER ":=" expression
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                    CALL IDENTIFIER
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_proc, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | "?" IDENTIFIER
                {
                    int stl, varNr;
                    int returnValue = st.lookup($2, st_var, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | "!" expression
                | BEGIN statementList END
                | IF condition THEN statement
                | WHILE condition DO statement
                | DEBUG
                | /* epsilon */
                ;

statementList:  statement
                | statementList ";" statement
                ;

condition:      ODD expression
                | expression operator expression
                ;

operator:       "#" 
                | "=" 
                | "<" 
                | "<=" 
                | ">" 
                | ">="
                ;

expression:     term
                | addSubSign term
                | expression addSubSign term
                ;

addSubSign:     "+"
                | "-"
                ;

term:           factor
                | term multDivSign factor
                ;

multDivSign:    "*"
                | "/"
                ;

factor:         IDENTIFIER
                {
                    int stl, varNr;
                    int returnValue = st.lookup($1, st_var|st_const, stl, varNr);
                    if (returnValue != 0) return 1;
                }
                | INTEGER
                | "(" expression ")"
                ;
%%