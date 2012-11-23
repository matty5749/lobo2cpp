#include "myRename.h"

extern int opterr;

char* myRename(int paramargc, char** const paramargv)
{
	int optch;
	
	char format[] = "n:";
	
	opterr = 1;

		if ( paramargc == 2 )
		{
			printf("La traduction du code source se trouve dans le fichier traduction.cpp\n");
			return "traduction.cpp";
		}
		else
		{
			if( (optch = getopt(paramargc, paramargv, format) ) != -1 )
			{
				optind = 1;

				while ( (optch = getopt(paramargc, paramargv, format) ) != -1 )
				{
					switch ( optch )
					{
						case 'n' :
						{
							char *name = (char*)malloc(sizeof(char)*(strlen(optarg)+1));
							strcpy(name, optarg);

							if (strstr(name, ".cpp") == NULL)
							{
								char *temp = (char*)malloc(sizeof(char)*(strlen(name)+5));
								strcpy(temp, name);
								strcat(temp, ".cpp\0");
								free(name);
								name = temp;
							}

							rename("traduction.cpp", name);	
							printf ("La traduction du code source se trouve dans le fichier %s  \n", name);

							return name;
						break;
						}

						default:
							printf("La traduction du code source se trouve dans le fichier traduction.cpp\n");
							return "traduction.cpp";
						break;
					}
				}
			}
			else 
			{
				printf("La traduction du code source se trouve dans le fichier traduction.cpp\n");
				return "traduction.cpp";
			}
		}
}
