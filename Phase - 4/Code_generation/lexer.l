/*Definition Section*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
int yylex();
void comment();
FILE* cpp_file;
%}

/* Rules Section */

blanks [ \t]+
letter [a-zA-Z]
digit [0-9]
constant ({digit}+)

%%

\n {yylineno++; fprintf(cpp_file,"%s",yytext);}
[/][*]([^*]|[*]+[^*/])*[*]+[/] {comment(); fprintf(cpp_file,"%s",yytext);}
[/][/][^\n]* {fprintf(cpp_file,"%s",yytext);}

"void" { strcpy(yylval.obj.value, yytext); return VOID; }
"int" { strcpy(yylval.obj.value, yytext); return INT; }
"float" { strcpy(yylval.obj.value, yytext); return FLOAT; }
"char" { strcpy(yylval.obj.value, yytext); return CHAR; }
"string" { strcpy(yylval.obj.value, yytext); return STRING; }
"bool" { strcpy(yylval.obj.value, yytext); return BOOL; }
"point" { strcpy(yylval.obj.value, yytext); return POINT; }
"line" { strcpy(yylval.obj.value, yytext); return LINE; }
"circle" { strcpy(yylval.obj.value, yytext); return CIRCLE; }
"parabola" { strcpy(yylval.obj.value, yytext); return PARABOLA; }
"hyperbola" { strcpy(yylval.obj.value, yytext); return HYPERBOLA; }
"ellipse" { strcpy(yylval.obj.value, yytext); return ELLIPSE; }

"NULL" { strcpy(yylval.obj.value, yytext); return NULL_; }
"if" { strcpy(yylval.obj.value, yytext); return IF; }
"elif" { strcpy(yylval.obj.value, yytext); return ELIF; }
"else" { strcpy(yylval.obj.value, yytext); return ELSE; }
"continue" { strcpy(yylval.obj.value, yytext); return CONTINUE; }

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

int yywrap(){
    return 1;
}
"+=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"-=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"*=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"/=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"%=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"|=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }
"&=" { strcpy(yylval.obj.value, yytext); return ASSIGN_OP; }

"<=" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }
"<" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }
">=" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }
">" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }
"==" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }
"!=" { strcpy(yylval.obj.value, yytext); return RELATIVE_OP; }

"-" { strcpy(yylval.obj.value, yytext); return SUB_OP; }
"+" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }
"*" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }
"/" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }
"%" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }
"|" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }
"&" {  strcpy(yylval.obj.value, yytext); return ARITHMETIC_OP; }

    cout << "Equation of the hyperbola: " << myHyperbola.equation() << endl;

    point testPointHyperbola = {1.0, 0.0};
    cout << "Is the point on the hyperbola? " << (myHyperbola.is_point(testPointHyperbola) ? "Yes" : "No") << endl;

    cout << "Eccentricity of the hyperbola: " << myHyperbola.eccentricity() << endl;

    line normalLineHyperbola = myHyperbola.normal({1.0, 0.0});
    cout << "Equation of the normal line for hyperbola: " << normalLineHyperbola.equation() << endl;

    line tangentLineHyperbola = myHyperbola.tangent({1.0, 0.0});
    cout << "Equation of the tangent line for hyperbola: " << tangentLineHyperbola.equation() << endl;

    return 0;
}
