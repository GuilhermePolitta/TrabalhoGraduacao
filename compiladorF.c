
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "compilador.h"


/* -------------------------------------------------------------------
 *  variáveis globais
 * ------------------------------------------------------------------- */

FILE* fp=NULL;
void geraCodigo (char* rot, char* comando) {

  if (fp == NULL) {
    fp = fopen ("MEPA", "w");
  }

  if ( rot == NULL ) {
    fprintf(fp, "%s", comando); fflush(fp);
  } else {
    fprintf(fp, "%s: %s \n", rot, comando); fflush(fp);
  }
}

int imprimeErro ( char* erro ) {
  fprintf (stderr, "Erro na linha %d - %s\n", nl, erro);
  exit(-1);
}

atributoTabela *criaAtributo(char nome[TAM_TOKEN]) {
	atributoTabela *newAtributo = malloc(sizeof(atributoTabela));
	strncpy(newAtributo->nome , nome, TAM_TOKEN);
	newAtributo->limite = 0;
	return newAtributo;
}

/// TODO por enquanto so esta sendo copiado o que ele vem da entrada, temos que trocar para os tipos corretos
void setTipoAtributo(atributoTabela *atributoMod, char tipo[TAM_TOKEN]) {
	strncpy(atributoMod->tipo, tipo, TAM_TOKEN);
}

void setPrimaryKey(atributoTabela *atributoMod, BOOL primary) {
	atributoMod->primary = primary;
}

void setForeignKey(atributoTabela *atributoMod, BOOL foreign) {
	atributoMod->foreign = foreign;
}

void setLimite(atributoTabela *atributoMod, int limite) {
	//TODO talvez ja mudar a string de tipo para ficar mais facil
	atributoMod->limite = limite;
}

table *criaTabela (char nome[TAM_TOKEN]) {
	table *newTable = malloc(sizeof(table));
	strncpy(newTable->nome , nome, TAM_TOKEN);
	newTable->tam = 0;
	newTable->listaAtributos = NULL;
	return newTable;
}

void addAtributoNaTabela(atributoTabela *atributoAdd, table *tableAdd) {
	tableAdd->listaAtributos = realloc(tableAdd->listaAtributos, (tableAdd->tam + 1) *(sizeof(atributoTabela)));
	tableAdd->listaAtributos[tableAdd->tam] = *atributoAdd;
	tableAdd->tam++;
}

void criaRailsFromTabela(table *tableSql) {
	geraCodigo (NULL, "rails generate model ");
	int i = 0;
	for (i = 0; i< tableSql->tam; i++) {
		if (tableSql->listaAtributos[i].primary) {
			continue;
		} else if (tableSql->listaAtributos[i].foreign) {
			//TODO logica de foreign key
		} else {
			geraCodigo (NULL, tableSql->listaAtributos[i].nome);
			geraCodigo (NULL, ":");
			geraCodigo (NULL, tableSql->listaAtributos[i].tipo);
			// TODO logica de limite (aqui ou no setLimite)
			geraCodigo (NULL, " ");
		}
	}
	geraCodigo (NULL, "--force \n");
}


