%{
#include "stdio.h"

int yylex(void);
int yytext(void);
extern int yyin;

#define YYERROR_VERBOSE 1
%}



%token FONCTION PARAMETRES DEBUT RETOUR FIN_FONCTION POINT_VIRGULE
%token APPEL FIN_REPETE DECLARE AFFECTE AFFICHE REPETE
%token CHAINE  OPERATEUR_BINAIRE IDENTIFIANT
%token NOMBRE

%start program
%%

program :
	ensInstructions {printf("\nLe code source lobo est syntaxiquement correct!\n");}
	;
	
ensInstructions:
	instructions 
	| ensInstructions instructions
	;
	
instructions :
     	definition_fonction 
	| appel_fonction POINT_VIRGULE
	| repete
	| instruction_simple POINT_VIRGULE
	;
	
definition_fonction:
	FONCTION IDENTIFIANT PARAMETRES identifiants DEBUT ensInstructions RETOUR expression POINT_VIRGULE FIN_FONCTION
	;

identifiants:
	/*vide*/
	| IDENTIFIANT
	| "\n"
	;
	
appel_fonction :
	APPEL IDENTIFIANT ensParametres
	;
	
repete :
	REPETE NOMBRE DEBUT ensInstructions FIN_REPETE
	;
	
instruction_simple :
	declare_variable
	|affecte_variable
	|affiche_chaine
	|affiche_variable
	;
	
declare_variable:
	DECLARE IDENTIFIANT
	;
	
affecte_variable:
	AFFECTE IDENTIFIANT expression
	;
	
affiche_chaine:
	AFFICHE CHAINE
	;

affiche_variable:
	AFFICHE IDENTIFIANT
	;
	
expression:
	parametre 
	|OPERATEUR_BINAIRE expression expression
	;

ensParametres:
	/*vide*/
	|parametre ensParametres
	;
	
parametre:
	IDENTIFIANT
	| NOMBRE
	;
	
%%

//#include "lex.yy.c"//Fichier c generer par flex de lobo2cpp.l
int main(int argc, char **argv) 
{
	if(argc == 2) 
	{
		FILE* fichier;
		if(!(fichier=fopen(argv[1], "r"))) return 1;
		
		yyin=(int)fichier;
		yyparse();
		fclose(fichier);
	}
return 0;
}

int yyerror(char *s)
{
	char* chaine=(void *)yytext;
	printf("%s sur : %s \n", s ,chaine);
	return 0;
}
