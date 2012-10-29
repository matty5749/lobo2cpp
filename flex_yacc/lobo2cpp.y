%{
#include "stdio.h"

int yylex(void);
int yytext(void);
extern int yyin;

#define YYSTYPE char*
#define YYERROR_VERBOSE 1
%}

%token FONCTION PARAMETRES DEBUT RETOUR FIN_FONCTION POINT_VIRGULE
%token APPEL FIN_REPETE DECLARE AFFECTE AFFICHE REPETE
%token CHAINE  OPERATEUR_BINAIRE IDENTIFIANT NOMBRE

%start program
%%

program :
	ensDefinitionFonction ensInstructions 
	{
		printf("\nLe code source lobo est syntaxiquement correct!\nLa traduction du code source se trouve dans le fichier traduction.cpp\n");
		FILE* fichier=fopen("traduction.cpp","w");
		if (fichier)
		{
			fprintf(fichier,"#include <stdio.h>\n#include <math.h>\n#include <iostream>\nusing namespace std;\n\n");
			fprintf(fichier,(const char*)$1);
			fprintf(fichier,"int main(int argc,char** argv)\n{\n");
			fprintf(fichier,(const char*)$2);
			fprintf(fichier,"return 0;\n}");
		}
	}
	;

ensDefinitionFonction:
	/*vide*/ {asprintf(&$$,"");}
	|ensDefinitionFonction definition_fonction {asprintf(&$$,"%s%s",$1,$2);}
	;
		
ensInstructions:
	instructions {asprintf(&$$,"%s",$1);}
	|ensInstructions instructions {asprintf(&$$,"%s%s",$1,$2);}
	;
	
instructions :
	appel_fonction POINT_VIRGULE {asprintf(&$$,"%s",$1);}
	|repete {asprintf(&$$,"%s",$1);}
	|instruction_simple POINT_VIRGULE {asprintf(&$$,"%s",$1);}
	;
	
definition_fonction:
	FONCTION IDENTIFIANT PARAMETRES identifiants DEBUT ensInstructions RETOUR expression POINT_VIRGULE FIN_FONCTION
	{
	asprintf(&$$,"int %s(%s)\n{\n%sreturn %s;\n}\n\n",$2,$4,$6,$8);
	}
	;

identifiants:
	/*vide*/ {asprintf(&$$,"");}
	|IDENTIFIANT  {asprintf(&$$,"int %s",$1);}
	|identifiants IDENTIFIANT  {asprintf(&$$,"%s,int %s",$1,$2);}
	
	;
	
appel_fonction :
	APPEL IDENTIFIANT ensParametres
	{
	asprintf(&$$,"%s(%s);\n",$2,$3);
	}
	;
	
repete :
	REPETE NOMBRE DEBUT ensInstructions FIN_REPETE
	{
		asprintf(&$$,"int repete=1;\nwhile (repete<=%s)\n{\n%srepete++;\n}\n",$2,$4);
	}
	;
	
instruction_simple :
	declare_variable {asprintf(&$$,"%s",$1);}
	|affecte_variable {asprintf(&$$,"%s",$1);}
	|affiche_chaine {asprintf(&$$,"%s",$1);}
	|affiche_variable {asprintf(&$$,"%s",$1);}
	;
	
declare_variable:
	DECLARE IDENTIFIANT {asprintf(&$$,"int %s ;\n",$1);}
	;
	
affecte_variable:
	AFFECTE IDENTIFIANT expression {asprintf(&$$,"%s = %s ;\n",$2,$3);}
	;
	
affiche_chaine:
	AFFICHE CHAINE {asprintf(&$$,"cout<<%s<<endl;\n",$2);}
	;

affiche_variable:
	AFFICHE IDENTIFIANT {asprintf(&$$,"cout<<%s<<endl;\n",$2);}
	;
	
expression:
	parametre {asprintf(&$$,"%s",$1);}
	|OPERATEUR_BINAIRE expression expression {asprintf(&$$,"%s%s%s",$2,$1,$3);}
	;

ensParametres:
	/*vide*/ {asprintf(&$$,"");}
	|ensParametres parametre {asprintf(&$$,"%s",$2);}
	;
	
parametre:
	IDENTIFIANT
	|NOMBRE
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
		printf("\n%d\n",yyparse());
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
