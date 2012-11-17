#include "myRename.h"

extern int opterr;

int myRename(int paramargc, char** const paramargv)
{
	int optch;
	
	char format[] = "n:";

		if ( paramargc == 2)
		{
			name = (char*)malloc(sizeof(char)*strlen("traduction.cpp")+1);
			strcpy(name,"traduction.cpp");
			printf("La traduction du code source se trouve dans le fichier traduction.cpp\n");
		}
		else
		{
			while ( (optch = getopt(paramargc, paramargv, format) ) != -1)
			{
				switch ( optch )
				{
					case 'n' :
					{
						name = (char*)malloc(sizeof(char)*strlen(optarg)+1);
						strcpy(name, optarg);
						if (strstr(name, ".cpp") == NULL)
							strcat(name, ".cpp\0");
						rename("traduction.cpp", name);	
						printf ("La traduction du code source se trouve dans le fichier %s  \n", name);
					break;
					}
			
					default:
						
					break;	
				}
			}
		}
}
