%{
#include <stdio.h>
#include <stdlib.h>
extern FILE* yyout;
int yylex(void);
int yyerror();
%}

%token VOID
%token INT
%token FLOAT
%token CHAR
%token STRING
%token BOOL
%token POINT
%token LINE
%token CIRCLE
%token PARABOLA
%token HYPERBOLA
%token ELLIPSE

%token NULL_
%token IF
%token ELSE
%token CONTINUE
%token BREAK
%token RETURN
%token FOR
%token WHILE
%token PRINT

%token EQUATION
%token ECCENTRICITY
%token TANGENT
%token NORMAL
%token IS_POINT
%token CENTRE
%token RADIUS
%token XCOR
%token YCOR
%token SLOPE

%token COMMA
%token SEMICOLON
%token COLON

%token OFLOWER
%token CFLOWER
%token OBRACKET
%token CBRACKET
%token OSQUARE
%token CSQUARE

%token NEG_OP
%token AND_OP
%token OR_OP
%token ACCESS_OP
%token INCREMENT_OP
%token DECREMENT_OP

%token POWER_ASSIGN
%token ADD_ASSIGN
%token SUB_ASSIGN
%token MUL_ASSIGN
%token DIV_ASSIGN
%token MOD_ASSIGN
%token BIT_AND_ASSIGN
%token BIT_OR_ASSIGN

%token LTE_OP
%token LT_OP
%token GTE_OP
%token GT_OP
%token EQ_OP
%token NEQ_OP

%token POWER_OP
%token ADD_OP
%token SUB_OP
%token MUL_OP
%token DIV_OP
%token MOD_OP
%token BIT_AND_OP
%token BIT_OR_OP

%token ASSIGN
%token ID
%token FLOAT_CONST
%token INT_CONST
%token CHAR_CONST
%token STRING_CONST
%token BOOL_CONST

%start S

%%
/*productions*/
S : function_declarations S
  | function_definitions S
  | dec_stmt S
  | /*empty*/
  ;

function_declarations : data_type ID OBRACKET par_list CBRACKET SEMICOLON {fprintf(yyout," : function declaration");}
                      | data_type ID OBRACKET CBRACKET SEMICOLON {fprintf(yyout," : function declaration");}
                      | VOID ID OBRACKET par_list CBRACKET SEMICOLON {fprintf(yyout," : function declaration");}
                      | VOID ID OBRACKET CBRACKET SEMICOLON {fprintf(yyout," : function declaration");}
                      ;

function_definitions : data_type ID OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER  {fprintf(yyout," : function definition");}
                     | data_type ID OBRACKET CBRACKET OFLOWER stmt CFLOWER {fprintf(yyout," : function definition");}
                     | VOID ID OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER {fprintf(yyout," : function definition");}
                     | VOID ID OBRACKET CBRACKET OFLOWER stmt CFLOWER {fprintf(yyout," : function definition");}
                     ;

par_list : data_type ID COMMA par_list
         | data_type ID
         ;
         
stmt : OFLOWER stmt CFLOWER
     | conditional_stmt stmt
     | loop_stmt stmt 
     | exp_stmt stmt
     | dec_stmt stmt
     | print_stmt stmt
     | call stmt
     | R stmt
     | OFLOWER BREAK SEMICOLON CFLOWER stmt
     | OFLOWER CONTINUE SEMICOLON CFLOWER stmt
     | /*empty*/
     ;
 
call : call_stmt SEMICOLON {fprintf(yyout," : call statement");}
     ;

R : return_stmt SEMICOLON {fprintf(yyout," : return statement");}
  ;

dec_stmt : data_type dlist SEMICOLON  {fprintf(yyout," : declaration statement");}
         ;
      
dlist : d_list COMMA dlist
      | d_list
      ; 

d_list : ID ASSIGN conditional_exp
       | ID L
       ;

L : /*empty*/
  | OSQUARE ID CSQUARE L
  | OSQUARE INT_CONST CSQUARE L
  | OSQUARE FLOAT_CONST CSQUARE L
  ;

exp_stmt : ID L ASSIGN conditional_exp SEMICOLON {fprintf(yyout," : assignment expression statement");}
         | assign_exp SEMICOLON {fprintf(yyout," : assignment expression statement");}
         | update_exp SEMICOLON {fprintf(yyout," : update expression statement");}
         ;
         
conditional_stmt : IF while_body OFLOWER stmt CFLOWER {fprintf(yyout," : conditional statement");}
                 | IF while_body OFLOWER stmt CFLOWER ELSE conditional_stmt {fprintf(yyout," : conditional statement");}
                 | IF while_body OFLOWER stmt CFLOWER ELSE OFLOWER stmt CFLOWER {fprintf(yyout," : conditional statement");}
                 ;
                 
loop_stmt : WHILE while_body OFLOWER stmt CFLOWER {fprintf(yyout," : loop");}
          | FOR for_body OFLOWER stmt CFLOWER {fprintf(yyout," : loop");}
          ;
          
while_body : OBRACKET conditional_exp CBRACKET
           ;
           
for_body : OBRACKET ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON assign_exp CBRACKET
         | OBRACKET INT ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON assign_exp CBRACKET
         | OBRACKET non_int ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON assign_exp CBRACKET
         | OBRACKET ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON update_exp CBRACKET
         | OBRACKET INT ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON update_exp CBRACKET
         | OBRACKET non_int ID L ASSIGN conditional_exp SEMICOLON conditional_exp SEMICOLON update_exp CBRACKET
         | OBRACKET INT ID COLON ID CBRACKET
         ;

assign_exp : ID L POWER_ASSIGN conditional_exp
           | ID L ADD_ASSIGN conditional_exp
           | ID L SUB_ASSIGN conditional_exp
           | ID L MUL_ASSIGN conditional_exp
           | ID L DIV_ASSIGN conditional_exp
           | ID L MOD_ASSIGN conditional_exp
           | ID L BIT_AND_ASSIGN conditional_exp
           | ID L BIT_OR_ASSIGN conditional_exp
           ;

conditional_exp : OBRACKET conditional_exp OR_OP conditional_exp CBRACKET
                | OBRACKET conditional_exp AND_OP conditional_exp CBRACKET
                | OBRACKET NEG_OP conditional_exp CBRACKET
                | OBRACKET conditional_exp CBRACKET
                | E LTE_OP E
                | E LT_OP E
                | E GTE_OP E
                | E GT_OP E
                | E EQ_OP E
                | E NEQ_OP E
                | E
                | OSQUARE E COMMA E CSQUARE
                | OFLOWER E COMMA E CFLOWER
                | OFLOWER OSQUARE E COMMA E CSQUARE COMMA E CFLOWER
                | OFLOWER E COMMA E COMMA E CFLOWER
                | OFLOWER OSQUARE E COMMA E CSQUARE COMMA E COMMA E CFLOWER
                ;

E : OBRACKET E ADD_OP E CBRACKET
  | OBRACKET E SUB_OP E CBRACKET
  | OBRACKET E MUL_OP E CBRACKET
  | OBRACKET E DIV_OP E CBRACKET
  | OBRACKET E MOD_OP E CBRACKET
  | OBRACKET E POWER_OP E CBRACKET
  | OBRACKET E BIT_OR_OP E CBRACKET
  | OBRACKET E BIT_AND_OP E CBRACKET
  | SUB_OP E
  | ID L
  | call_stmt
  | INT_CONST
  | FLOAT_CONST
  | CHAR_CONST
  | STRING_CONST
  | NULL_
  | BOOL_CONST
  ;

update_exp : ID L INCREMENT_OP
           | ID L DECREMENT_OP
           ;
           
return_stmt : RETURN conditional_exp 
            ;

call_stmt : ID OBRACKET call_list CBRACKET
          | ID OBRACKET CBRACKET
          | ID L ACCESS_OP property
          ;

property : IS_POINT OBRACKET OSQUARE E COMMA E CSQUARE CBRACKET
         | IS_POINT OBRACKET E CBRACKET
         | EQUATION
         | ECCENTRICITY
         | TANGENT OBRACKET OSQUARE E COMMA E CSQUARE CBRACKET
         | TANGENT OBRACKET E CBRACKET
         | NORMAL OBRACKET OSQUARE E COMMA E CSQUARE CBRACKET
         | NORMAL OBRACKET E CBRACKET
         | CENTRE
         | RADIUS
         | XCOR
         | YCOR
         | SLOPE
         ;

call_list : conditional_exp COMMA call_list
          | conditional_exp
          ;

print_stmt : PRINT OBRACKET E CBRACKET SEMICOLON
           ;

data_type : INT
          | non_int
          ;
          
non_int : CHAR 
        | STRING 
        | BOOL 
        | POINT 
        | FLOAT 
        | LINE 
        | CIRCLE 
        | ELLIPSE 
        | PARABOLA 
        | HYPERBOLA
        ;
%%

int yywrap(){}

int main() {
    yyparse();   
    return 0;
}

int yyerror() {
    fprintf(yyout, " : invalid statement");
    exit(1);
    return 0;
}
