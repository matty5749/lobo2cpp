cible:

	bison -d lobo2cpp.y
	flex -l lobo2cpp.l
	
	gcc lex.yy.c lobo2cpp.tab.c tableSymbole.c -lfl -o lobo2cpp
				
clean:
	rm lobo2cpp lex.yy.c lobo2cpp.tab.h lobo2cpp.tab.c a.out
	
