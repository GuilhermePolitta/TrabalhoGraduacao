%{


#include<stdio.h>
#include<string.h>

#include "tradutor.h"
#include "tradutor.tab.h"

#define IMPRIME(STR) printf("%s    # %s \n", STR, token);

int nl = 1;  

%}

pulo_linha [\n]

descarte [\t ]+
 

ident [a-zA-Z][a-zA-Z1-9_]*

numero [0-9]+

string "\'".*"\'"

comentario "(*".*"*)"

%%

{pulo_linha} {nl++;} 

{descarte}

{comentario}
(?i:auto_increment) { simbolo  = simb_autoIncremente;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("auto_increment ");
          return AUTOINCREMENTE;
 }

(?i:primary) { simbolo  = simb_primary;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("primary ");
          return PRIMARY;
 }


{string} { simbolo = simb_string;
           strncpy (string, yytext, TAM_STRING);
           IMPRIME(" string  ");
           return STRING;
         }

(?i:alter) { simbolo  = simb_alter;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("alter ");
          return ALTER;
 }

(?i:table) { simbolo  = simb_table;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("table ");
          return TABLE;
 }

(?i:column) { simbolo  = simb_column;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("column ");
          return COLUMN;
 }

(?i:row) { simbolo  = simb_row;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("row ");
          return ROW;
 }

(?i:create) { simbolo  = simb_create;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("create ");
          return CREATE;
 }

(?i:comment) { simbolo  = simb_comment;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("comment ");
          return COMMENT;
 }

(?i:on) { simbolo  = simb_on;
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("on ");
          return ON;
 }

(?i:is) { simbolo  = simb_is;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("is ");
          return IS;
 }

(?i:foreign) { simbolo  = simb_foreign;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("foreign ");
          return FOREIGN;
 }

(?i:key) { simbolo  = simb_key;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("key ");
          return KEY;
 }

(?i:references) { simbolo  = simb_references;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("references ");
          return REFERENCES;
 }

program { simbolo  = simb_program;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("program ");
          return PROGRAM;
 }

var      { simbolo = simb_var;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("var  ");
          return VAR;
 }

begin { simbolo = simb_begin;
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("begin ");
          return T_BEGIN;
 }

end { simbolo = simb_end;
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME("end  ");
          return T_END;
 }

:= { simbolo = simb_atribuicao;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" atribuicao  ");
          return ATRIBUICAO;  
 }

\; { simbolo = simb_ponto_e_virgula;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" pt_virgula  ");
          return PONTO_E_VIRGULA;
 }

\: { simbolo = simb_dois_pontos;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" dois pontos ");
          return DOIS_PONTOS;
 }

\, { simbolo = simb_virgula;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" virgula  ");
          return VIRGULA;
 }


\. { simbolo = simb_ponto;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" ponto  ");
          return PONTO; 
    }

\(  { simbolo = simb_abre_parenteses;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" abre_parenteses  ");
          return ABRE_PARENTESES;
    }

\)  { simbolo = simb_fecha_parenteses;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" fecha_parenteses ");
          return FECHA_PARENTESES;
 }

\'  { simbolo = simb_aspas_simples;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" aspas_simples ");
          return ASPAS_SIMPLES;
 }

\"  { simbolo = simb_aspas_duplas;  
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" aspas_duplas ");
          return ASPAS_DUPLAS;
 }

{ident} { simbolo = simb_identificador; 
          strncpy (token, yytext, TAM_TOKEN);
          IMPRIME(" ident  ");
          return IDENT;
        }


%%

