#ifndef TABLE_SYMBOLE_H
#define TABLE_SYMBOLE_H

struct s_Symbole 
{
        char* id;
	int est_utilise;
	int ligne;
	int arite;
	struct s_Symbole* suivant;
};

typedef struct s_Symbole Symbole ;

Symbole* insererSymbole (char*,int ligne);
Symbole* getSymbole (char*);
int lectureTableDeSymbole();//Renvoie le nombre d'erreur et 0 si pas d'erreur

#endif
