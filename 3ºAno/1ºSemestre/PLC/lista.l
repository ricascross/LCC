%option noyywrap
    //quer não quero definir e que utilizo o standard

%%
    //(?i:lista) case sensitive lista
(?i:lista)      {return (LISTA);}
[0-9]+          { yylval.valI = atoi(yytext); return (NUMERO);}
[A-Za-z]+       {yylval.valS = strdup(yytext); return (PALAVRA);}
\.              {return ('.');}
\,              {return (',');}
\#              {return ('#');}
.|\n            { ; }
%%