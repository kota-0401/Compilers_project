/*Definition Section*/

%{
    #include<stdio.h>
    #include<stdlib.h>
    void comment();
%}

/* Rules Section */

blanks [ \t]+
letter [a-zA-Z]
digit [0-9]
constant ({digit}+)

%%

\n {yylineno++; }
[/][*]([^*]|[*]+[^*/])*[*]+[/] {comment(); }
[/][/][^\n]* {; }

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

"<=" {fprintf(yyout,"Line %d - LTE_OP: %s\n",yylineno,yytext); }
"<" {fprintf(yyout,"Line %d - LT_OP: %s\n",yylineno,yytext); }
">=" {fprintf(yyout,"Line %d - GTE_OP: %s\n",yylineno,yytext); }
">" {fprintf(yyout,"Line %d - GT_OP: %s\n",yylineno,yytext); }
"==" {fprintf(yyout,"Line %d - EQ_OP: %s\n",yylineno,yytext); }
"!=" {fprintf(yyout,"Line %d - NEQ_OP: %s\n",yylineno,yytext); }

"^" {fprintf(yyout,"Line %d - POWER_OP: %s\n",yylineno,yytext); }
"+" {fprintf(yyout,"Line %d - ADD_OP: %s\n",yylineno,yytext); }
"-" {fprintf(yyout,"Line %d - SUB_OP: %s\n",yylineno,yytext); }
"*" {fprintf(yyout,"Line %d - MUL_OP: %s\n",yylineno,yytext); }
"/" {fprintf(yyout,"Line %d - DIV_OP: %s\n",yylineno,yytext); }
"%" {fprintf(yyout,"Line %d - MOD_OP: %s\n",yylineno,yytext); }
"|" {fprintf(yyout,"Line %d - BIT_AND_OP: %s\n",yylineno,yytext); }
"&" {fprintf(yyout,"Line %d - BIT_OR_OP: %s\n",yylineno,yytext); }

"=" {fprintf(yyout,"Line %d - ASSIGN: %s\n",yylineno,yytext); }
{letter}[{digit}|{letter}|_]* {fprintf(yyout,"Line %d - ID: %s\n",yylineno,yytext); }
{constant}?[.]{constant}? {fprintf(yyout,"Line %d - FLOAT_CONST: %s\n",yylineno,yytext); }
{constant} {fprintf(yyout,"Line %d - INT_CONST: %s\n",yylineno,yytext); }
['][\\][n]['] {fprintf(yyout,"Line %d - CHAR_CONST: %s\n",yylineno,yytext); }
['][^'\n]*['] {fprintf(yyout,"Line %d - CHAR_CONST: %s\n",yylineno,yytext); }
["][^"\n]*["] {fprintf(yyout,"Line %d - STRING_CONST: %s\n",yylineno,yytext); }
{blanks} {; }
. {fprintf(yyout,"Line %d - INVALID TOKEN: %s\n",yylineno,yytext); }

%%

/* User Subroutine section */

void comment() {
  int i;
  for (i = 0; i < yyleng; i++) {
    if (yytext[i] == '\n') {
      yylineno++;
    }
  }
}

int yywrap() {
  return 1;
}

int main() {
  yylex();
  return 0;
}
