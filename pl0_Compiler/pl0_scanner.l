%{
    #include "y.tab.hpp"
%}

ident [A-Za-z][A-Za-z0-9]*
number [0-9]+

%%
"CONST"     return t_const;
"VAR"       return t_var;
"PROCEDURE" return t_procedure;
"CALL"      return t_call;
"BEGIN"     return t_begin;
"END"       return t_end;
"IF"        return t_if;
"THEN"      return t_then;
"WHILE"     return t_while;
"DO"        return t_do;
"ODD"       return t_odd;
"DEBUG"     return t_debug;
"?"         return t_q_mark;
"!"         return t_e_mark;
"."         return t_dot;
"="         return t_equal;
","         return t_comma;
";"         return t_semicolon;
":="        return t_assignment;
"#"         return t_hashtag;
"<"         return t_lt;
">"         return t_gt;
"<="        return t_lte;
">="        return t_gte;
"+"         return t_plus;
"-"         return t_minus;
"*"         return t_mult;
"/"         return t_div;
"("         return t_open_brack;
")"         return t_close_brack;
{number}    {strncpy(yylval.txt, yytext, 16); return t_number;}
{ident}     {strncpy(yylval.txt, yytext, 16); return t_ident;}
[ \t\n]     /* do nothing */;
.           return t_error;
%%
int yywrap() {
    return 1;
}