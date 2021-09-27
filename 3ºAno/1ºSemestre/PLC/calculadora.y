%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
float TabId[26];
%}

%union{ float valN; char valC;}
%token <valC>ID
%token <valN>NUM
%token  TRUE FALSE
%token E OU
%token EQ NE LT LE GT GE
%type <valN> Expr Termo Fator ExprR

%%
Exprs : Ex 
      | Exprs Ex 
      ;

Ex    : Atrib
      | Expr '\n'             {printf("-> %f\n", $1);}
      ;

Atrib : ID '=' ExprR '\n'        {TabId[$1-'A'] = $3; printf(" → %f\n",$3);}
      ;

ExprR : Expr            {$$ = $1;}
      | Expr EQ Expr    {$$ = ($1 == $3);}
      ;

Expr  : Termo                  { $$ = $1; }
      | Expr '+' Termo      { $$ = $1 + $3; }
      | Expr '-' Termo     { $$ = $1 - $3; }
      | Expr OU Termo       { $$ = $1 || $3; } 
      ;

Termo : Fator              { $$ = $1; }
      | Termo '*' Fator    { $$ = $1 * $3; }
      | Termo '/' Fator    { $$ = $1 / $3; }
      | Termo  E  Fator    { $$ = $1 &&  $3; } 
      ;

Fator : NUM             { $$ = $1; }
      | '-'   NUM       { $$ = (-1) * $2; }
      | ID              { $$ = TabId[$1-'A']; }
      | TRUE            {  $$ = 1;  }
      | FALSE           {  $$ = 0;  }
      |  '(' Expr ')'   { $$ = $2; }
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
        printf("Inicio do parsing\n");
        yyparse();
        printf("Fim do parsing\n");
        return 0;
}
