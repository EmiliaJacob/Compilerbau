#include <iostream>
#include <string>

extern int yyparse();
extern int yylex();
extern FILE* yyin;

int main (int argc, char * argv []) {
    if (argc != 2) {
        std::cerr << "Keine Eingabedatei!\n";
        return 1;
    }

    std::string name = argv[1];
    name.append(".pl0");
    FILE* datei = fopen(name.c_str(), "r");
    
    // filename = name;
    // filename.append(".asm");

    if(datei == NULL){
        std::cerr << "Datei konnte nicht gelesen werden\n";
        return 1;
    }
    
    yyin = datei;
    int erg = yyparse();
    std::cout << "Parse-Ergebnis: " << erg << std::endl;
    fclose(datei);

    return erg;
}

int yyerror(const char *s) {
     std::cout << s << std::endl;
     return 0;
}
