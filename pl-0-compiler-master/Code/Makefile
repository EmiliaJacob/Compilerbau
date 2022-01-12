#Executables
pl-0: lex.yy.o y.tab.o main.o symtab.o zwischencode.o codeerzeugung.o
	${CPP} -o pl-0 lex.yy.o y.tab.o main.o symtab.o zwischencode.o codeerzeugung.o

#Main
main.o: main.cpp
	${CPP} -c main.cpp

#Scanner
lex.yy.o: lex.yy.cpp
	${CPP} -c lex.yy.cpp

lex.yy.cpp: pl-0.l y.tab.cpp
	flex --header-file=lex.yy.hpp -o lex.yy.cpp pl-0.l

#Parser
y.tab.o: y.tab.cpp 
	${CPP} -c y.tab.cpp

y.tab.cpp: pl-0.y
	bison -d pl-0.y -o y.tab.cpp

# Symboltabelle
symtab.o: pl0-symtab.cpp pl0-symtab.hpp
	$(CPP) -c pl0-symtab.cpp -o symtab.o

# Zwischencode
zwischencode.o: pl0-zwischencode.cpp pl0-zwischencode.hpp
	$(CPP) -c pl0-zwischencode.cpp -o zwischencode.o

# Codeerzeugung
codeerzeugung.o: pl0-codeerzeugung.cpp pl0-codeerzeugung.hpp 
	$(CPP) -c pl0-codeerzeugung.cpp -o codeerzeugung.o


#Clear
clean:
	rm lex.yy.cpp || true &>/dev/null 
	rm lex.yy.hpp || true &>/dev/null
	rm y.tab.hpp || true &>/dev/null
	rm y.tab.cpp || true &>/dev/null
	rm *.o || true &>/dev/null
	rm pl-0 || true &>/dev/null

	