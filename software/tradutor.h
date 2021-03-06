#define TAM_TOKEN 70
#define TAM_STRING 256

#define IS_ASPAS_SIMPLES 1
#define IS_ASPAS_DUPLAS 2

typedef enum simbolos { 
  simb_program, simb_var, simb_begin, simb_end, 
  simb_identificador, simb_numero, simb_string,
  simb_ponto, simb_virgula, simb_ponto_e_virgula, simb_dois_pontos,
  simb_atribuicao, simb_abre_parenteses, simb_fecha_parenteses,
  simb_aspas_simples, simb_aspas_duplas,
  simb_create, simb_table, simb_column, simb_row, simb_alter,
  simb_comment, simb_on, simb_is,
  simb_foreign, simb_key, simb_references, simb_primary, simb_autoIncremente
} simbolos;



/* -------------------------------------------------------------------
 * variáveis globais
 * ------------------------------------------------------------------- */

typedef int BOOL;

typedef struct atributoTabela {
	char nome[TAM_TOKEN];
	char tipo[TAM_TOKEN];
	int limite;
	BOOL primary;
	BOOL foreign;

	//modificado daqui pra baixo
	struct table *foreignTable;
} atributoTabela;

typedef struct table {
	char nome[TAM_TOKEN];
	atributoTabela *listaAtributos;
	int tam;
} table;

typedef struct listaTabelas {
	table *tabelas;
	int tam;
}listaTabelas;

extern simbolos simbolo, relacao;
extern char token[TAM_TOKEN];
extern char string[TAM_STRING];
extern int nivel_lexico;
extern int desloc;
extern int nl;

simbolos simbolo, relacao;
char token[TAM_TOKEN];

atributoTabela *atributo;
atributoTabela *atributoForegin;
table *tabela;

//modificado aqui
listaTabelas *lista;


atributoTabela *criaAtributo(char nome[TAM_TOKEN]);
	
void setTipoAtributo(atributoTabela *atributoMod, char tipo[TAM_TOKEN]);

//void setPrimaryKey(atributoTabela *atributoMod, BOOL primary);

atributoTabela * setPrimaryKey(char nome[TAM_TOKEN], table *tableSource, BOOL primary);

atributoTabela * setForeignKey(char nome[TAM_TOKEN], table *tableSource, BOOL foreign);

void setForeignTable(atributoTabela *atributoMod, char nomeTabela[TAM_TOKEN]);

table *buscaTablea(char nome[TAM_TOKEN]);

void setLimite(atributoTabela *atributoMod, int limite);

atributoTabela *buscaAtributoNaTabela(char nome[TAM_TOKEN], table *tableSource);

table *criaTabela (char nome[TAM_TOKEN]);

void addAtributoNaTabela(atributoTabela *atributoAdd, table *tableAdd);

void criaRailsFromTabela(table *tableSql);

void imprimeTabelas();

void imprimeConteudoTabela(table *tableSql);

char *getTipoCorretoAtributo(atributoTabela *atributoAdd);
