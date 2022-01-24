%option caseless
%{
    #include "y.tab.hpp"
%}

ident [A-Za-z_][A-Za-z_0-9]*
number [0-9]+

%%
"CONST"     return t_CONST;
"VAR"       return t_VAR;
"PROCEDURE" return t_PROCEDURE;
"CALL"      return t_CALL;
"BEGIN"     return t_BEGIN;
"END"       return t_END;
"IF"        return t_IF;
"THEN"      return t_THEN;
"WHILE"     return t_WHILE;
"DO"        return t_DO;
"ODD"       return t_ODD;
"DEBUG"     return t_DEBUG;
"?"         return t_Q_MARK;
"!"         return t_E_MARK;
"."         return t_DOT;
"="         return t_EQUAL;
","         return t_COMMA;
";"         return t_SEMICOLON;
":="        return t_ASSIGNMENT;
"#"         return t_N_EQUAL;
"<"         return t_LT;
">"         return t_GT;
"<="        return t_LTE;
">="        return t_GTE;
"+"         return t_PLUS;
"-"         return t_MINUS;
"*"         return t_MULT;
"/"         return t_DIV;
"("         return t_OPEN_BRACK;
")"         return t_CLOSE_BRACK;
{number}    {strncpy(yylval.txt, yytext, 16); return t_NUMBER;}
{ident}     {strncpy(yylval.txt, yytext, 16); return t_IDENT;}
[ \t\n]     /* do nothing */;
.           /* do nothing */;
%%
int yywrap() {
    return 1;
}