
// Testar se funciona corretamente o empilhamento de parâmetros
// passados por valor ou por referência.


%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "compilador.h"

int num_vars;
int qual_aspas;
char string[TAM_STRING];

char atributo[TAM_TOKEN];
char tipoAtributo[TAM_TOKEN];
char especificacaoAtributo[TAM_TOKEN];

%}

%token PROGRAM ABRE_PARENTESES FECHA_PARENTESES 
%token VIRGULA PONTO_E_VIRGULA DOIS_PONTOS PONTO
%token T_BEGIN T_END VAR IDENT ATRIBUICAO STRING
%token TABLE COLUMN ROW
%token CREATE ALTER
%token COMMENT ON IS
%token ASPAS_SIMPLES ASPAS_DUPLAS

%%

//rails generate scaffold HighScore game:string score:integer
t_create	:
			CREATE {
				 geraCodigo (NULL, "rails generate scaffold "); 
				}
			TABLE 
			IDENT {geraCodigo (NULL, token); } 
			ABRE_PARENTESES lista_ident FECHA_PARENTESES
			PONTO_E_VIRGULA{geraCodigo (NULL, "\n"); } prox_regra
;

add_campo_tabela: IDENT {
						strncpy(atributo, token, TAM_TOKEN);
						geraCodigo (NULL, token);
						geraCodigo (NULL, ":");
					} IDENT  {
					strncpy(tipoAtributo, token, TAM_TOKEN);
						geraCodigo (NULL, token);
						geraCodigo (NULL, " ");
					} add_campo_tabela2
;

add_campo_tabela2	:	IDENT {
							strncpy(especificacaoAtributo, token, TAM_TOKEN);
							if (!strcmp(token, "AUTO_INCREMENT")) {
								printf("\nachei auto_increment, ignore\n");
							}
						} add_campo_tabela2 |
;
//da pra criar um token pros tipos de possiveis de campos (int, varchar, etc) fica mais facil
lista_ident: 	lista_ident  VIRGULA  add_campo_tabela| add_campo_tabela

/*atributos	:
			IDENT tipo_atributo {

			}
;*/

t_alter		:
			ALTER {
				 geraCodigo (NULL, "ALTERANDO"); 
				}
			TABLE {
				 geraCodigo (NULL, "TABELA"); 
				}
			IDENT {geraCodigo (NULL, token); } PONTO_E_VIRGULA{geraCodigo (NULL, "\n"); }  prox_regra
;

t_comment	:
			COMMENT ON tipos IDENT {geraCodigo (NULL, token); }  IS {

			} STRING PONTO_E_VIRGULA{geraCodigo (NULL, "\n"); } prox_regra
;

tipos		:
			TABLE  {geraCodigo (NULL, "TABELA");}|
			COLUMN {geraCodigo (NULL, "COLUNA");}|
			ROW	   {geraCodigo (NULL, "LINHA");}
;

prox_regra	: t_alter  |
			  t_create |
			  t_comment|
;

%%
	
main (int argc, char** argv) {
   FILE* fp;
   extern FILE* yyin;

   if (argc<2 || argc>2) {
         printf("usage compilador <arq>a %d\n", argc);
         return(-1);
      }

   fp=fopen (argv[1], "r");
   if (fp == NULL) {
      printf("usage compilador <arq>b\n");
      return(-1);
   }
   qual_aspas = 0;

/* -------------------------------------------------------------------
 *  Inicia a Tabela de Símbolos
 * ------------------------------------------------------------------- */

   yyin=fp;
   yyparse();

   return 0;
}