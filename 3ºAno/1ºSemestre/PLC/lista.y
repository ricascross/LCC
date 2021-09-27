%{
#include <stdio.h>
#include <string.h>
int conta, contaN = 0;
float media, soma=0.0;
char *max;
%}

%union {int valI; char* valS;}

%token LISTA      
%token <valI> NUMERO      //símbolos terminais
%token <valS> PALAVRA   //símbolos terminais
%type <valI> elemento elementos 

%%
Entrada: Listas '#'
       ;

Listas: Lista 
      | Listas Lista
      ;

Lista: LISTA elementos '.' {printf("Comprimento: %d\n", conta); 
                            media = contaN?soma/contaN:0; 
                            printf("A media é: %f\n", media);
                            soma = 0; 
                            contaN = 0; 
                            printf("A maior palavra é: %s\n", max);
                            max = strdup("");
                            printf("Somatorio: %d", $2);
                            }
     ;
elementos: elemento {conta = 1; $$ = 1;}
         | elementos ',' elemento {conta++; $$ = $1 + $3}
         ;
elemento: NUMERO {contaN++; soma += $1; $$ = $1}
        | PALAVRA { if (strcmp($1,max) > 0) {max = strdup($1);} $$ = 0;}
        ;
%%


#include "lex.yy.c"
int yyerror(char* s)
{
        printf("Frase Inválida:%s\n", s);
        return 1;
}

int main(void)
{
        max = strdup("");
        printf("Inicio do parsing\n");
        yyparse();
        printf("Fim do parsing\n");
        return 0;
}