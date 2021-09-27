%{
/* Declaracoes C diversas */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 50

char entrevistador[MAX];
char entrevistado[MAX];
%}
  //start condicions
%x rentrevistador rentrevistado comentario  

%%
^(E|e)(U|u)[" "]*[=][" "]*              {BEGIN rentrevistador; }
<rentrevistador>[^.]+                   {strcpy(entrevistador, yytext);} /*rentrevistador reconhece tudo como se fosse o inicio da linha*/
<rentrevistador>\.\n                    {BEGIN INITIAL; }

^(e|E)(L|l)(E|e)[" "]*[=][" "]*         {BEGIN rentrevistado;}
<rentrevistado>[^.]+                    {strcpy(entrevistado, yytext);} /*rentrevistador reconhece tudo como se fosse o inicio da linha*/
<rentrevistado>\.\n                     {BEGIN INITIAL; }

^(E|e)(U|u)[" "]*\:                     {printf("%s: ", entrevistador);}
^(e|E)(L|l)(E|e)[" "]*:                 {printf("%s: ", entrevistado);}

    //\/\/.*                                   {;} // no comentário não vai fazer nad, vai ignorar
"//".*\n                                {;} // no comentário não vai fazer nad, vai ignorar
"/*"                                    {BEGIN comentario}
<comentario> "*/"                       {BEGIN INITIAL}
<comentario>(.|\n)                      {;}                    
%%

int yywrap()
{ return(1); }

int main()
{ 
    yylex();
    return 0; 
}