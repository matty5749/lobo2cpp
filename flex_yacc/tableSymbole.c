#include "tableSymbole.h"
#include "stdlib.h"
#include "stdio.h"


Symbole* tableSymbole;

Symbole* insererSymbole (char* identifiant,int ligne)
{
	Symbole* ptr=(Symbole*)getSymbole(identifiant);
	
	//Si le symbole n'est pas déjà present dans la table des symboles --> Creation du symbole
	if(!ptr) 
	{
		ptr = (Symbole *) malloc (sizeof (Symbole));
		ptr->id = identifiant;
		ptr->est_utilise = 0;
		ptr->ligne = ligne;
		ptr->arite = 0;
		ptr->suivant = tableSymbole;
		tableSymbole = ptr;
	} 
	/*
	else 
	{
		if(ptr->type != Symb_type) {
			
			char *msg;
			asprintf(&msg, "Attention: la variable %s a deja ete definie a la ligne %d\n",
				Symb_id, ptr->line);
			asprintf(&msg, "%sAncien type : %s\nNouveau type : %s\n",
				msg, getType(ptr->type), getType(Symb_type));
			yyerror(msg);
			ptr->type = Symb_type;
			ptr->line = yylineno;
		}
	}
	*/
	return ptr;
}


Symbole* getSymbole (char* identifiant)
{
	Symbole* ptr;
	for (ptr = tableSymbole; ptr; ptr = ptr->suivant)
		if (strcmp (ptr->id,identifiant) == 0)
			return ptr;
	return 0;
}


int lectureTableDeSymbole()
{
	Symbole* ptr;
	int nb_erreur=0;
	for (ptr = tableSymbole; ptr; ptr = ptr->suivant)
		if (!ptr->est_utilise)
		{
			nb_erreur++;
			fprintf(stderr, "Ligne %d :\n",ptr->ligne);
			fprintf(stderr, "Attention: la variable %s n'est pas utilisee\n\n", ptr->id);
		}
	return nb_erreur;
}

