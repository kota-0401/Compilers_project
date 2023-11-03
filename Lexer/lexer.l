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
[/][*]([^*]|[*]+[^*/])*[*]+[/] {fprintf(yyout,"Line %d - COMMENT\n",yylineno); comment(); }
[/][/][^\n]* {fprintf(yyout,"Line %d - COMMENT\n",yylineno); }

"void" {fprintf(yyout,"Line %d - VOID: %s\n",yylineno,yytext);}
"int" {fprintf(yyout,"Line %d - INT: %s\n",yylineno,yytext);}
"float" {fprintf(yyout,"Line %d - FLOAT: %s\n",yylineno,yytext);}
"char" {fprintf(yyout,"Line %d - CHAR: %s\n",yylineno,yytext);}
"string" {fprintf(yyout,"Line %d - STRING: %s\n",yylineno,yytext);}
"bool" {fprintf(yyout,"Line %d - BOOL: %s\n",yylineno,yytext);}
"point" {fprintf(yyout,"Line %d - POINT: %s\n",yylineno,yytext);}
"line" {fprintf(yyout,"Line %d - LINE: %s\n",yylineno,yytext);}
"circle" {fprintf(yyout,"Line %d - CIRCLE: %s\n",yylineno,yytext);}
"parabola" {fprintf(yyout,"Line %d - PARABOLA: %s\n",yylineno,yytext);}
"hyperbola" {fprintf(yyout,"Line %d - HYPERBOLA: %s\n",yylineno,yytext);}
"ellipse" {fprintf(yyout,"Line %d - ELLIPSE: %s\n",yylineno,yytext);}

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
