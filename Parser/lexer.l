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

"NULL" {fprintf(yyout,"%s",yytext); return NULL_; }
"if" {fprintf(yyout,"%s",yytext); return IF; }
"else" {fprintf(yyout,"%s",yytext); return ELSE; }
"continue" {fprintf(yyout,"%s",yytext); return CONTINUE; }
"break" {fprintf(yyout,"%s",yytext); return BREAK; }
"return" {fprintf(yyout,"%s",yytext); return RETURN; }
"for" {fprintf(yyout,"%s",yytext); return FOR; }
"while" {fprintf(yyout,"%s",yytext); return WHILE; }
"print" {fprintf(yyout,"%s",yytext); return PRINT; }

"equation" {fprintf(yyout,"%s",yytext); return EQUATION; }
"eccentricity" {fprintf(yyout,"%s",yytext); return ECCENTRICITY; }
"tangent" {fprintf(yyout,"%s",yytext); return TANGENT; }
"normal" {fprintf(yyout,"%s",yytext); return NORMAL; }
"is_point" {fprintf(yyout,"%s",yytext); return IS_POINT; }
"centre" {fprintf(yyout,"%s",yytext); return CENTRE; }
"radius" {fprintf(yyout,"%s",yytext); return RADIUS; }
"xcor" {fprintf(yyout,"%s",yytext); return XCOR; }
"ycor" {fprintf(yyout,"%s",yytext); return YCOR; }
"slope"  {fprintf(yyout,"%s",yytext); return SLOPE; }


"{" {fprintf(yyout,"Line %d - OFLOWER: %s\n",yylineno,yytext); }
"}" {fprintf(yyout,"Line %d - CFLOWER: %s\n",yylineno,yytext); }
"(" {fprintf(yyout,"Line %d - OBRACKET: %s\n",yylineno,yytext); }
")" {fprintf(yyout,"Line %d - CBRACKET: %s\n",yylineno,yytext); }
"[" {fprintf(yyout,"Line %d - OSQUARE: %s\n",yylineno,yytext); }
"]" {fprintf(yyout,"Line %d - CSQUARE: %s\n",yylineno,yytext); }

NEG {fprintf(yyout,"Line %d - NEG_OP: %s\n",yylineno,yytext); }
AND {fprintf(yyout,"Line %d - AND_OP: %s\n",yylineno,yytext); }
OR  {fprintf(yyout,"Line %d - OR_OP: %s\n",yylineno,yytext); }
"." {fprintf(yyout,"Line %d - ACCESS_OP: %s\n",yylineno,yytext); }
"++" {fprintf(yyout,"Line %d - INCREMENT_OP: %s\n",yylineno,yytext); }
"--" {fprintf(yyout,"Line %d - DECREMENT_OP: %s\n",yylineno,yytext); }
"^=" {fprintf(yyout,"Line %d - POWER_ASSIGN: %s\n",yylineno,yytext); }
"+=" {fprintf(yyout,"Line %d - ADD_ASSIGN: %s\n",yylineno,yytext); }
"-=" {fprintf(yyout,"Line %d - SUB_ASSIGN: %s\n",yylineno,yytext); }
"*=" {fprintf(yyout,"Line %d - MUL_ASSIGN: %s\n",yylineno,yytext); }
"/=" {fprintf(yyout,"Line %d - DIV_ASSIGN: %s\n",yylineno,yytext); }
"%=" {fprintf(yyout,"Line %d - MOD_ASSIGN: %s\n",yylineno,yytext); }
"|=" {fprintf(yyout,"Line %d - BIT_AND_ASSIGN: %s\n",yylineno,yytext); }
"&=" {fprintf(yyout,"Line %d - BIT_OR_ASSIGN: %s\n",yylineno,yytext); }


%%
