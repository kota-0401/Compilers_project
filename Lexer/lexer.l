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

"NULL" {fprintf(yyout,"Line %d - NULL: %s\n",yylineno,yytext);}
"if" {fprintf(yyout,"Line %d - IF: %s\n",yylineno,yytext);}
"else" {fprintf(yyout,"Line %d - ELSE: %s\n",yylineno,yytext);}
"continue" {fprintf(yyout,"Line %d - CONTINUE: %s\n",yylineno,yytext);}
"break" {fprintf(yyout,"Line %d - BREAK: %s\n",yylineno,yytext);}
"return" {fprintf(yyout,"Line %d - RETURN: %s\n",yylineno,yytext);}
"for" {fprintf(yyout,"Line %d - FOR: %s\n",yylineno,yytext);}
"while" {fprintf(yyout,"Line %d - WHILE: %s\n",yylineno,yytext);}
"print" {fprintf(yyout,"Line %d - PRINT: %s\n",yylineno,yytext);}

"equation" {fprintf(yyout,"Line %d - EQUATION: %s\n",yylineno,yytext);}
"eccentricity" {fprintf(yyout,"Line %d - ECCENTRICITY: %s\n",yylineno,yytext);}
"tangent" {fprintf(yyout,"Line %d - TANGENT: %s\n",yylineno,yytext);}
"normal" {fprintf(yyout,"Line %d - NORMAL: %s\n",yylineno,yytext);}
"is_point" {fprintf(yyout,"Line %d - IS_POINT: %s\n",yylineno,yytext);}
"centre" {fprintf(yyout,"Line %d - CENTRE: %s\n",yylineno,yytext);}
"radius" {fprintf(yyout,"Line %d - RADIUS: %s\n",yylineno,yytext);}
"xcor" {fprintf(yyout,"Line %d - XCOR: %s\n",yylineno,yytext);}
"ycor" {fprintf(yyout,"Line %d - YCOR: %s\n",yylineno,yytext);}
"slope"  {fprintf(yyout,"Line %d - SLOPE: %s\n",yylineno,yytext);}


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
