#define TAM_TOKEN 16
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
  simb_comment, simb_on, simb_is
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
} atributoTabela;

typedef struct table {
	char nome[TAM_TOKEN];
	atributoTabela *listaAtributos;
	int tam;
} table;


extern simbolos simbolo, relacao;
extern char token[TAM_TOKEN];
extern char string[TAM_STRING];
extern int nivel_lexico;
extern int desloc;
extern int nl;

simbolos simbolo, relacao;
char token[TAM_TOKEN];

atributoTabela *atributo;
table *tabela;