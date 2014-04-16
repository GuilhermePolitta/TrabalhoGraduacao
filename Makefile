$DEPURA=1

tradutor: lex.yy.c y.tab.c tradutor.o tradutor.h
	gcc lex.yy.c tradutor.tab.c tradutor.o -o tradutor -ll -ly -lc

lex.yy.c: tradutor.l tradutor.h
	flex tradutor.l

y.tab.c: tradutor.y tradutor.h
	bison tradutor.y -d -v

tradutor.o : tradutor.h tradutorF.c
	gcc -c tradutorF.c -o tradutor.o

clean : 
	rm -f tradutor.tab.* lex.yy.c 
