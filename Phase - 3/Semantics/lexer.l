/*Definition Section*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
int yylex();
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
[/][/][^\n]* {;}

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
initialize_exp : increment_exp_1 ASSIGN conditional_exp SEMICOLON {
                string temp_type = get_type($<obj.value>1);
                if(!(type_checking(temp_type,$<obj.eletype>4))){
                  cout << "Semantic Error at Line" << yylineno << ": expected rhs of type: " << $<obj.eletype>1 << endl;
           }
           }
               ;

conditional_exp : NEG_OP conditional_exp {$<obj.eletype>$ = $<obj.eletype>2;}
                | K {$<obj.eletype>$ = $<obj.eletype>1;}
                ;
K : K AND_OP I {
                if(type_checking($<obj.eletype>1,$<obj.eletype>3)){
                  $<obj.eletype>$ = $<obj.eletype>1;
                }
                else{
                  cout << "Semantic Error at Line" << yylineno << ": expected rhs of type: " << $<obj.eletype>1 << endl;
                }
              }
  | I {$<obj.type>$ = $<obj.type>1;}
  ;
