%option noyywrap

%%
[+\-*/()\n\r=]       {return (yytext[0]);}
"=="                {return (EQ);}
[?i:e]              {return (E);}
[?i:true]           {return (TRUE);}
[?i:false]          {return (FALSE);}
[?i:ou]             {return (OU);}
[A-Za-z]            {yylval.valC= toupper(yytext[0]); return (ID);}
[0-9]+(\.[0-9]+)?   {yylval.valN = atof(yytext); return (NUM);}
%%