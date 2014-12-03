
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tradutor.h"


/* -------------------------------------------------------------------
 *  variáveis globais
 * ------------------------------------------------------------------- */

FILE* fp=NULL;
void geraCodigo (char* rot, char* comando) {

  if (fp == NULL) {
    fp = fopen ("RAILS", "w");
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
	setLimite(newAtributo,0);
	newAtributo->primary = 0;
	newAtributo->foreign = 0;
	return newAtributo;
}

/// TODO por enquanto so esta sendo copiado o que ele vem da entrada, temos que trocar para os tipos corretos
void setTipoAtributo(atributoTabela *atributoMod, char tipo[TAM_TOKEN]) {
	strncpy(atributoMod->tipo, tipo, TAM_TOKEN);
}

atributoTabela * setPrimaryKey(char nome[TAM_TOKEN], table *tableSource, BOOL primary) {
	atributoTabela *atributoMod = buscaAtributoNaTabela(nome, tableSource);
	if (atributoMod != NULL) {
		atributoMod->primary = primary;
	}
}

/*void setPrimaryKey(atributoTabela *atributoMod, BOOL primary) {
	
	atributoMod->primary = primary;
	printf("seting primary key of %s to %d\n", atributoMod->nome, atributoMod->primary);
}*/

atributoTabela * setForeignKey(char nome[TAM_TOKEN], table *tableSource, BOOL foreign) {
	atributoTabela *atributoMod = buscaAtributoNaTabela(nome, tableSource);
	if (atributoMod != NULL) {
		atributoMod->foreign = foreign;
	}
	
	return atributoMod;
	
}

void setForeignTable(atributoTabela *atributoMod, char nomeTabela[TAM_TOKEN]) {
	table *tableForeing = buscaTablea(nomeTabela);
	if (tableForeing != NULL) {
		atributoMod->foreignTable = tableForeing;
	}
}

void setLimite(atributoTabela *atributoMod, int limite) {
	//TODO talvez ja mudar a string de tipo para ficar mais facil
	atributoMod->limite = limite;
}

atributoTabela *buscaAtributoNaTabela(char nome[TAM_TOKEN], table *tableSource) {
	int i = 0;
	for (i=0;i<tableSource->tam;i++) {
		if (strcmp(tableSource->listaAtributos[i].nome, nome) == 0 ) {
			return &tableSource->listaAtributos[i];
		}	
	}
	return NULL;
}

table *buscaTablea(char nome[TAM_TOKEN]) {
	int i = 0;
	for (i=0;i<lista->tam;i++) {
		if (strcmp(lista->tabelas[i].nome, nome) == 0 ) {
			return &lista->tabelas[i];
		}
	}
	return NULL;
}

table *criaTabela (char nome[TAM_TOKEN]) {
	table *newTable = malloc(sizeof(table));
	strncpy(newTable->nome , nome, TAM_TOKEN);
	newTable->tam = 0;
	printf("criei %s\n", newTable->nome);
	newTable->listaAtributos = NULL;

	//modificado daqui pra baixo
	lista->tabelas = realloc(lista->tabelas, (lista->tam + 1) * (sizeof(table)));
	lista->tabelas[lista->tam] = *newTable;
	lista->tam++;

	return newTable;
}

void addAtributoNaTabela(atributoTabela *atributoAdd, table *tableAdd) {
	tableAdd->listaAtributos = realloc(tableAdd->listaAtributos, (tableAdd->tam + 1) *(sizeof(atributoTabela)));
	tableAdd->listaAtributos[tableAdd->tam] = *atributoAdd;
	tableAdd->tam++;
}

char *getTipoCorretoAtributo(atributoTabela *atributoAdd) {
	/*if (strcmp(atributoAdd->tipo, "VARCHAR") == 0 ) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "string");
		return retorno;
	} else if (strcmp(atributoAdd->tipo, "DOUBLE") == 0 ) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "decimal{42.6}");
		return retorno; 
	} else if (strcmp(atributoAdd->tipo, "INT") == 0 ) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "integer");
		return retorno; 
	} else {
		return atributoAdd->tipo;
	}*/

	printf(">>>>o tipo original e %s\n", atributoAdd->tipo);
	
	if (isEqual(atributoAdd->tipo,"VARCHAR" ) || strstr(atributoAdd->tipo, "VARCHAR") != NULL) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "string");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"DOUBLE" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "decimal{42.6}");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"INT" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "integer");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"FLOAT" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "float");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"DATETIME" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "timestamp");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"TINYINT(1)" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "boolean");
		return retorno;
	} else if (strstr(atributoAdd->tipo, "BLOB") != NULL) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "binary");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"DECIMAL" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "decimal");
		return retorno;
	} else if (strstr(atributoAdd->tipo, "TEXT") != NULL) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "text");
		return retorno;
	} else  if (isEqual(atributoAdd->tipo,"TIME" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "time");
		return retorno;
	} else if (isEqual(atributoAdd->tipo,"DATE" )) {
		char *retorno = malloc(TAM_TOKEN *sizeof(char));
		strcpy(retorno, "date");
		return retorno;
	}

	printf("Tipo de variavel invalido! Abortando\n");
	exit(1);
	return NULL;
}

BOOL isEqual(char *primeiro, char* segundo) {
	if (strcmp(primeiro, segundo) == 0) {
		return 1;
	}

	return 0;
}

void criaRailsFromTabela(table *tableSql) {
	geraCodigo (NULL, "rails generate scaffold ");
	geraCodigo (NULL, tableSql->nome);
	geraCodigo (NULL, " ");
	int i = 0;

	for (i = 0; i< tableSql->tam; i++) {
		//printf("atribute name: %s\n",tableSql->listaAtributos[i].nome );
		if (tableSql->listaAtributos[i].primary) {
			/*if (isEqual(tableSql->listaAtributos[i].tipo,"INT") ){
				geraCodigo (NULL, tableSql->listaAtributos[i].nome);
				geraCodigo (NULL, ":primary_key");	
			} */
			continue;
		} else if (tableSql->listaAtributos[i].foreign) {
			geraCodigo (NULL, tableSql->listaAtributos[i].foreignTable->nome);
			geraCodigo (NULL, ":references ");

		} else {
			geraCodigo (NULL, tableSql->listaAtributos[i].nome);
			geraCodigo (NULL, ":");
			geraCodigo (NULL, getTipoCorretoAtributo(&tableSql->listaAtributos[i]));
			
			geraCodigo (NULL, " ");
		}
	}
	geraCodigo (NULL, "--force \n");
}

void imprimeTabelas() {	
	printf("lista->tam = %d\n", lista->tam);
	int i;
	for (i = 0; i < lista->tam; i++) {
		printf("\ntable %d = %s\n\n", i, lista->tabelas[i].nome);
	}
}


void imprimeConteudoTabela(table *tableSql) {	
	printf("===================================\n");
	printf("tableSql->tam = %d\n", tableSql->tam);
		int i = 0;
	for (i = 0; i< tableSql->tam; i++) {
		printf("Atributo:%s primary:%d\n", tableSql->listaAtributos[i].nome, tableSql->listaAtributos[i].primary);
	}
	printf("===================================\n");
}
