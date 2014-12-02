
%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "tradutor.h"

int num_vars;
int qual_aspas;
char string[TAM_STRING];

//char atributo[TAM_TOKEN];
char tipoAtributo[TAM_TOKEN];
char especificacaoAtributo[TAM_TOKEN];

int yylex();
void yyerror(const char *s);
%}

%token PROGRAM ABRE_PARENTESES FECHA_PARENTESES 
%token VIRGULA PONTO_E_VIRGULA DOIS_PONTOS PONTO
%token T_BEGIN T_END VAR IDENT ATRIBUICAO STRING
%token TABLE COLUMN ROW
%token CREATE ALTER
%token COMMENT ON IS
%token ASPAS_SIMPLES ASPAS_DUPLAS
%token FOREIGN KEY REFERENCES PRIMARY AUTOINCREMENTE NUMERO

%%

//rails generate scaffold HighScore game:string score:integer
t_create	:
			CREATE TABLE IDENT { tabela =  criaTabela(token); } 
			ABRE_PARENTESES lista_ident FECHA_PARENTESES PONTO_E_VIRGULA  { criaRailsFromTabela(tabela); } prox_regra
;

//da pra criar um token pros tipos de possiveis de campos (int, varchar, etc) fica mais facil
lista_ident: 	lista_ident  VIRGULA  add_campo_tabela| add_campo_tabela

add_campo_tabela:
				FOREIGN KEY ABRE_PARENTESES IDENT {
					atributoForegin = setForeignKey(token, tabela, 1);
				} FECHA_PARENTESES REFERENCES IDENT {
					setForeignTable(atributoForegin, token);
				} ABRE_PARENTESES IDENT {
					//Esse IDENT é o nome do atributo da tabela referenciada
					//Nao eh utilizado
				} FECHA_PARENTESES |
				IDENT {
					atributo = criaAtributo(token);
				} IDENT  {
					setTipoAtributo(atributo, token);
					addAtributoNaTabela(atributo, tabela);
				} restriction_or_not 
;

restriction_or_not: ABRE_PARENTESES NUMERO FECHA_PARENTESES primary_or_not
					| primary_or_not
;

primary_or_not: AUTOINCREMENTE PRIMARY KEY {setPrimaryKey(atributo->nome, tabela, 1);}
				| PRIMARY KEY {
					
					// Nesse caso eh primary key mas nao eh um campo de ID e portanto nao pode ser ignorado
					setPrimaryKey(atributo->nome, tabela, 0);}
				|
;
				

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
			  t_comment| {geraCodigo (NULL, "rake db:migrate\n");}
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

   lista = (listaTabelas *) malloc (sizeof(listaTabelas));
   lista->tam = 0;

/* -------------------------------------------------------------------
 *  Inicia a Tabela de Símbolos
 * ------------------------------------------------------------------- */

   yyin=fp;
   yyparse();

   return 0;
}
void yyerror (const char *s) {
    fprintf (stderr, "%s\n", s);
}
