%{
#include<stdio.h>
%}

ident [a-zA-Z][a-zA-Z1-9_]*

%%

{ident} { printf(“encontrei um identificador válido!” ) }