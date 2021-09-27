%{
/* Declaracoes C diversas */
#include<stdio.h>
#include <strings.h>
int cnt = 0;
float saldo = 0.0;
%}
digito [0-9] 

/*(\+|\-)?digito+\.[0-9]{2} digito sem as chavetas não vai tomar o valor da variavel mas sim, participar na expressão regular, ou seja, aceitava +digito.00, e não se quer isso*/
/*(\+|\-)?[0-9]+  o ponto de interrogação significa um ou o outro, ou um e o outro. */
/* (\+|\-)?[0-9]+\.[0-9]{2}   {cnt++; saldo +=atoi(yytext)} no caso de calcular um saldo bancário, significa encontrar, por exemplo, (23,08), meter nas declarações float saldo= 0;*/
%%
[0-9]+                     {cnt++; printf("\n encontrei um numero cujo o dobro é: %d\n", 2*atoi(yytext)); } /*[0-9]+ tem um ou mais digitos; se cnt for uma variável incrementa, yytext armazena todos os caracteres*/
(\+|\-)?{digito}+\.[0-9]{2}   {cnt++; saldo +=atoi(yytext);} 
.|\n                       {  ; }  /*{;} significa retirá-lo do filtro; .|\n tudo o que não for algarismos, deita fora; . faz o match de todos os caracteres menos \n*/
%%

int yywrap()
{ return(1); }

int main()
{ 
    yylex();
    printf("Encontrei %d números\n", cnt); 
    printf("Saldo: %.2f\n", saldo); 
    return 0; 
}