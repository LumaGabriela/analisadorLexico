%{
#include <stdio.h>
#include <string.h>
%}
declaracoes                     int|char|void|float|double
biblioteca                      <[a-zA-Z_]+\.h>
identificador                   [a-zA-Z]+[0-9_]*[a-zA-Z]*
%x AFTER_PRINTF
%x AFTER_SCANF
%x AFTER_DECLAR
%x COMMENT
%%

<INITIAL>printf\s*\(        { BEGIN(AFTER_PRINTF);}

<AFTER_PRINTF>[^)]*\)\s*;   { printf("%s ->  Expressão printf\n", yytext); BEGIN(INITIAL); }
<AFTER_SCANF>[^)].          { }

<INITIAL>scanf\s*\(         { BEGIN(AFTER_SCANF);}
<AFTER_SCANF>[^)]*\)\s*;    { printf("%s ->  Expressão scanf\n", yytext); BEGIN(INITIAL); } 
<AFTER_SCANF>.          {/**/ }



<INITIAL>"/*"                            { printf("%s ->  Inicio do comentario\n", yytext); BEGIN(COMMENT); }
<INITIAL>"//"                            { printf("%s ->  Inicio do comentario\n", yytext); BEGIN(COMMENT); }
<COMMENT>"*/"        { printf("%s ->  Fim do comentario\n", yytext); BEGIN(INITIAL); }
<COMMENT>[\r\n]+     { printf("%s ->  Fim do comentario\n", yytext); BEGIN(INITIAL); }
<COMMENT>.+          { /*printf("%s ->  Conteudo do comentario\n", yytext); */}



<INITIAL>{declaracoes}                   {printf("%s ->  declaracao\n", yytext); BEGIN(AFTER_DECLAR);}
<AFTER_DECLAR>\s*\(        { printf("%s ->  Expressão scanf\n", yytext); BEGIN(INITIAL); }
<AFTER_DECLAR>[^)]*\)\s*;  { printf("%s ->  Expressão scanf\n", yytext); BEGIN(INITIAL); } 


[\{\}\[\]]*                     { /*printf("%s ->  Parentese fim\n", yytext);*/}
[\n]                            { /*printf("%s ->  Quebra de linha\n");*/} 
#include                        {printf("%s ->  definicao de inclusão\n", yytext);}
";"                             { /*printf("%s ->  Inicio do comentario\n", yytext);*/}
{biblioteca}                    {printf("%s ->  biblioteca incluida\n", yytext);}

"continue"|"break"|"return"     {printf("%s ->  palavra de controle de fluxo\n", yytext);}
if|else|else\sif                {printf("%s ->  condicional\n", yytext);}
=|==|!=|-|>|>=|<=|<|\+|&&|\|\|  {printf("%s ->  um operador\n", yytext);}
{identificador}                 {printf("%s ->  identificador\n", yytext);}








%%

int main() {
    printf("\nAnalisador lexico\n");
    yylex();
    return 0;
}