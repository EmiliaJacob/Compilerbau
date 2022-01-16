CC=gcc
CCPP=g++
all:	aassembler aarest-console

aassembler:	aassembler.l opcodes.h
	lex -o lex.yy.cpp aassembler.l
	$(CCPP) lex.yy.cpp -o aassembler

aarest-console: aarest-console.c opcodes.h
	$(CC) aarest-console.c stack.c -o aarest-console

clean:
	rm *.yy.* *.o
