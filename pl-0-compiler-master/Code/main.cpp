#include <iostream>
#include <string>
using namespace std;

extern int yyparse();
extern int yylex();
extern FILE* yyin;
int ergebnis;
extern string filename;

int main(int argc, char * argv []) {
    if(argc<=1) {
        cerr << "Fehlender Übergabeparameter\n";
        return 1;
    }
    FILE* datei;
    string name = argv[1];
    filename = name;
    filename.append(".asm");
    name.append(".pl0");
    datei=fopen(name.c_str(), "r");
    if(datei == NULL){
        cerr << "Datei konnte nicht gelesen werden\n";
        return 1;
    }
    cerr << "Datei konnte erfolgreich geöffnet werden.\n";
    yyin = datei;
    ergebnis = yyparse();
    fclose(datei);
    return ergebnis;
}

int yyerror(const char *s) {
     cerr << s << "\n";
     return 0;
}