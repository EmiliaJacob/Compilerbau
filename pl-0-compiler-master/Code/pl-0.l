%option caseless  
%{
    //extern int t_punkt, t_plus, t_minus, t_mal, t_div, t_kla_auf, t_kla_zu, t_ungleich,
    //extern int t_zuweisung, t_kleiner_gleich, t_kleiner, t_groesser_gleich, t_groesser,
    //extern int t_gleich, t_komma, t_semikolon, t_eingabe, t_ausgabe, t_const, t_var,
    //extern int t_procedure, t_call, t_begin, t_end, t_if, t_then, t_while, t_do, t_odd,
    //extern int t_number, t_ident, t_fehler, t_debug
    //extern struct{}
    #include "y.tab.hpp"
%}
%%
"."                     return t_punkt;
"+"                     return t_plus;
"-"                     return t_minus;
"*"                     return t_mal;
"/"                     return t_div;
"("                     return t_kla_auf;
")"                     return t_kla_zu;
"#"                     return t_ungleich;
":="                    return t_zuweisung;
"<="                    return t_kleiner_gleich;
"<"                     return t_kleiner;
">="                    return t_groesser_gleich;
">"                     return t_groesser;
"="                     return t_gleich;
","                     return t_komma;
";"                     return t_semikolon;
"?"                     return t_eingabe;
"!"                     return t_ausgabe;
"read"                  return t_eingabe;
"write"                 return t_ausgabe;
"const"                 return t_const;
"var"                   return t_var;
"procedure"             return t_procedure;
"call"                  return t_call;
"begin"                 return t_begin;
"end"                   return t_end;
"if"                    return t_if;
"then"                  return t_then;
"while"                 return t_while;
"do"                    return t_do;
"odd"                   return t_odd;
"debug"                 return t_debug;
[0-9]+                  {strncpy(yylval.txt, yytext, 16); return t_number;}
[A-Za-z]([A-Za-z0-9]*)  {strncpy(yylval.txt, yytext, 16); return t_ident;}
[ \t\n]                 /* do nothing */;
.                       return t_fehler;
%%
int yywrap() {
    return 1;
}