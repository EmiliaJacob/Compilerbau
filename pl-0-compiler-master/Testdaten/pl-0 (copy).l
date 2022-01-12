%option caseless  
%{
    //extern int t_punkt, t_plus, t_minus, t_mal, t_div, t_kla_auf, t_kla_zu, t_ungleich,
    //extern int t_zuweisung, t_kleiner_gleich, t_kleiner, t_groesser_gleich, t_groesser,
    //extern int t_gleich, t_komma, t_semikolon, t_eingabe, t_ausgabe, t_const, t_var,
    //extern int t_procedure, t_call, t_begin, t_end, t_if, t_then, t_while, t_do, t_odd,
    //extern int t_number, t_ident, t_fehler
    //extern struct{}
    //#include "y.tab.h"
%}
%%
"."                     printf("t_punkt\n");
"+"                     printf("t_plus\n");
"-"                     printf("t_minus\n");
"*"                     printf("t_mal\n");
"/"                     printf("t_div\n");
"("                     printf("t_kla_auf\n");
")"                     printf("t_kla_zu\n");
"#"                     printf("t_ungleich\n");
":="                    printf("t_zuweisung\n");
"<="                    printf("t_kleiner_gleich\n");
"<"                     printf("t_kleiner\n");
">="                    printf("t_groesser_gleich\n");
">"                     printf("t_groesser\n");
"="                     printf("t_gleich\n");
","                     printf("t_komma\n");
";"                     printf("t_semikolon\n");
"?"                     printf("t_eingabe\n");
"!"                     printf("t_ausgabe\n");
"const"                 printf("t_const\n");
"var"                   printf("t_var\n");
"procedure"             printf("t_procedure\n");
"call"                  printf("t_call\n");
"begin"                 printf("t_begin\n");
"end"                   printf("t_end\n");
"if"                    printf("t_if\n");
"then"                  printf("t_then\n");
"while"                 printf("t_while\n");
"do"                    printf("t_do\n");
"odd"                   printf("t_odd\n");
[0-9]+                  printf("t_number: %s\n", yytext);
[A-Za-z]([A-Za-z0-9]*)  printf("t_ident: %s\n", yytext);
[ \t\n]                 /* do nothing */;
.                       printf("t_fehler");
%%
int main() {
    yylex();       
    return 0;
}
int yywrap() {
    return 1;
}