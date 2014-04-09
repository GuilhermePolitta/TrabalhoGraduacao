
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

%}

%token PROGRAM ABRE_PARENTESES FECHA_PARENTESES 
%token VIRGULA PONTO_E_VIRGULA DOIS_PONTOS PONTO
%token T_BEGIN T_END VAR IDENT ATRIBUICAO STRING
%token TABLE COLUMN ROW
%token CREATE ALTER
%token COMMENT ON IS
%token ASPAS_SIMPLES ASPAS_DUPLAS

%%

t_create	:
			CREATE {
				 geraCodigo (NULL, "CRIANDO"); 
				}
			TABLE {
				 geraCodigo (NULL, "TABELA"); 
				}
			IDENT PONTO_E_VIRGULA prox_regra
;

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
			IDENT PONTO_E_VIRGULA prox_regra
;

t_comment	:
			COMMENT ON tipos IDENT IS {

			} STRING PONTO_E_VIRGULA prox_regra
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