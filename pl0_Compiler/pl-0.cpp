#include <iostream>
#include <string>

extern int yyparse();
extern int yylex();
extern FILE* yyin;
extern std::string file;

int main (int argc, char * argv []) {
    if (argc != 2) {
        std::cerr << "Keine Eingabedatei!\n";
        return 1;
    }

    std::string name = argv[1];
    file = name;
    name.append(".pl0");
    file.append(".asm");

    FILE* datei = fopen(name.c_str(), "r");
    
    if(datei == NULL){
        std::cerr << "Datei konnte nicht gelesen werden\n";
        return 1;
    }
    
    yyin = datei;
    int erg = yyparse();
    std::cerr << "Parse-Result: " << erg << "\n";
    fclose(datei);

    return erg;
}

int yyerror(const char *s) {
     std::cerr << s << "\n";
     return 0;
}
