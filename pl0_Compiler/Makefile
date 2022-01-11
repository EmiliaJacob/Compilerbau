export CPP=g++
#
# Makefile zu Pl/0
#
pl-0: lex.yy.o y.tab.o pl-0.o symtab.o
	${CPP} -o pl-0 \
		lex.yy.o y.tab.o pl-0.o symtab.o

pl-0.o: pl-0.cpp
	${CPP} -c pl-0.cpp

lex.yy.o: lex.yy.cpp
	${CPP} -c lex.yy.cpp

lex.yy.cpp: pl0_scanner.l y.tab.cpp
	flex --header-file=lex.yy.hpp -o lex.yy.cpp pl0_scanner.l

y.tab.o: y.tab.cpp
	${CPP} -c y.tab.cpp

y.tab.cpp: pl0_parser.y
	yacc -d pl0_parser.y -o y.tab.cpp

symtab.o: pl0-symtab.cpp pl0-symtab.hpp
	${CPP} -c pl0-symtab.cpp -o symtab.o

clean:
	rm lex.yy.* y.tab.* *.o pl-0