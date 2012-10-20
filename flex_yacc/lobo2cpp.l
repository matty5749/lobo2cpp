%{
#include "lobo2cpp.tab.h"
%}

NOMBRE ([0-9]+)
OPERATEUR_BINAIRE (\+|\-|\*|\/)
IDENTIFIANT ([a-zA-Z]+[a-zA-Z_]*)
/*Une chaine peut contenir tout les caracteres.A FAIRE: exceptés le caractere "*/
CHAINE (\".*\")
COMMENTAIRE (#.*\n)

%%
	/*Dans cette section , les commentaires doivent être précédé d'une tabulation*/



FONCTION {printf ("FONCTION");return FONCTION;}
PARAMETRES {printf ("PARAMETRES");return PARAMETRES;}
DEBUT {printf ("DEBUT");return DEBUT;}
RETOUR {printf ("RETOUR");return RETOUR;}
FIN_FONCTION {printf ("FIN_FONCTION");return FIN_FONCTION;}
; {printf (";");return POINT_VIRGULE;}
APPEL {printf ("APPEL");return APPEL;}
NOMBRE {printf ("NOMBRE");return NOMBRE;}
FIN_REPETE {printf ("FIN_REPETE");return FIN_REPETE;}
DECLARE {printf ("DECLARE");return DECLARE;}
AFFECTE {printf ("AFFECTE");return AFFECTE;}
AFFICHE {printf ("AFFICHE");return AFFICHE;}
REPETE {printf ("REPETE");return REPETE;}
{CHAINE} {printf("%s",yytext);return CHAINE;}
{OPERATEUR_BINAIRE} {printf("%s",yytext);return OPERATEUR_BINAIRE;}
{NOMBRE} {printf("%s",yytext);return NOMBRE;}
{IDENTIFIANT} {printf("%s",yytext);return IDENTIFIANT;}

	/*Les expressions ci dessous n'envoie pas d'information à yacc*/
[ \t] {printf("%s",yytext);};
\n {printf("\n");}
{COMMENTAIRE} {printf("%s",yytext);}

%%

