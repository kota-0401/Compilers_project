/*Definition Section*/

%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

/* Rules Section */

blanks [ \t]+
letter [a-zA-Z]
digit [0-9]
constant ({digit}+)

%%

\n {fprintf(yyout,"%s",yytext); }
[/][*]([^*]|[*]+[^*/])*[*]+[/] {fprintf(yyout,"%s",yytext); }
[/][/][^\n]* {fprintf(yyout,"%s",yytext); }

"void" {fprintf(yyout,"%s",yytext); return VOID; }
"int" {fprintf(yyout,"%s",yytext); return INT; }
"float" {fprintf(yyout,"%s",yytext); return FLOAT; }
"char" {fprintf(yyout,"%s",yytext); return CHAR; }
"string" {fprintf(yyout,"%s",yytext); return STRING; }
"bool" {fprintf(yyout,"%s",yytext); return BOOL; }
"point" {fprintf(yyout,"%s",yytext); return POINT; }
"line" {fprintf(yyout,"%s",yytext); return LINE; }
"circle" {fprintf(yyout,"%s",yytext); return CIRCLE; }
"parabola" {fprintf(yyout,"%s",yytext); return PARABOLA; }
"hyperbola" {fprintf(yyout,"%s",yytext); return HYPERBOLA; }
"ellipse" {fprintf(yyout,"%s",yytext); return ELLIPSE; }

%%
