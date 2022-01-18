#
# Makefile zu Pl/0
#
pl-0: lex.yy.o y.tab.o pl-0.o symtab.o tree.o codegeneration.o
	${CPP} -o pl-0 \
		lex.yy.o y.tab.o pl-0.o symtab.o tree.o codegeneration.o

pl-0.o: pl-0.cpp
	${CPP} -c pl-0.cpp

lex.yy.o: lex.yy.cpp
	${CPP} -c lex.yy.cpp

lex.yy.cpp: pl0_scanner.l y.tab.cpp
	flex --header-file=lex.yy.hpp -o lex.yy.cpp pl0_scanner.l

y.tab.o: y.tab.cpp
	${CPP} -c y.tab.cpp

y.tab.cpp: pl0_parser.y
	bison -d pl0_parser.y -o y.tab.cpp

symtab.o: pl0_symtab.cpp pl0_symtab.hpp
	${CPP} -c pl0_symtab.cpp -o symtab.o

tree.o: pl0_tree.cpp pl0_tree.hpp
	${CPP} -c pl0_tree.cpp -o tree.o

codegeneration.o: pl0_codegeneration.cpp pl0_codegeneration.hpp
	${CPP} -c pl0_codegeneration.cpp -o codegeneration.o

clean:
	rm lex.yy.* y.tab.* *.o pl-0