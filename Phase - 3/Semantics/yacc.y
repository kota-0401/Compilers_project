%{
#include <bits/stdc++.h>
#include "symbol_table.cpp"
extern FILE* yyin;
extern FILE *tokfile, *parsefile;

extern int yylineno;
int yylex(void);
void yyerror(const char *a);
%}

%union {
	struct variable_name {
    char* value;
    char* type ;
    char* eletype;
	} obj; 
}

%token <obj> VOID
%token <obj> INT
%token <obj> FLOAT
%token <obj> CHAR
%token <obj> STRING
%token <obj> BOOL
%token <obj> POINT
%token <obj> LINE
%token <obj> CIRCLE
%token <obj> PARABOLA
%token <obj> HYPERBOLA
%token <obj> ELLIPSE

%token <obj> NULL_
%token <obj> IF
%token <obj> ELIF
%token <obj> ELSE
%token <obj> CONTINUE
%token <obj> BREAK
%token <obj> RETURN
%token <obj> FOR
%token <obj> WHILE
%token <obj> PRINT
%token <obj> INPUT

%token <obj> EQUATION
%token <obj> ECCENTRICITY
%token <obj> TANGENT
%token <obj> NORMAL
%token <obj> IS_POINT
%token <obj> CENTRE
%token <obj> RADIUS
%token <obj> XCOR
%token <obj> YCOR
%token <obj> SLOPE



%token <obj> COMMA
%token <obj> SEMICOLON
%token <obj> COLON

%token <obj> OFLOWER
%token <obj> CFLOWER
%token <obj> OBRACKET
%token <obj> CBRACKET
%token <obj> OSQUARE
%token <obj> CSQUARE

%token <obj> NEG_OP
%token <obj> AND_OP
%token <obj> OR_OP
%token <obj> ACCESS_OP
%token <obj> INCREMENT_OP
%token <obj> DECREMENT_OP

%token <obj> ASSIGN_OP

%token <obj> RELATIVE_OP


%token <obj> SUB_OP
%token <obj> ARITHMETIC_OP

%token <obj> ASSIGN
%token <obj> ID
%token <obj> FLOAT_CONST
%token <obj> INT_CONST
%token <obj> CHAR_CONST
%token <obj> STRING_CONST
%token <obj> BOOL_CONST

%type <obj> N E
%type <obj> M S L J 
%type <obj> function_declarations function_definitions par_list dec_stmt data_type func_exp L_1


%start S

%%
/*productions*/
S : function_declarations S
  | function_definitions S
  | dec_stmt S 
  | /*empty*/{}
  ;

function_declarations : func_exp OBRACKET data_type CBRACKET OBRACKET par_list CBRACKET SEMICOLON {
                                                                    add_function_value = add_function($<obj.value>1, $<obj.value>3); 
                                                                    if(add_function_value) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }
                      | func_exp OBRACKET data_type CBRACKET OBRACKET CBRACKET SEMICOLON {
                                                                    add_function_value = add_function($<obj.value>1, $<obj.value>3); 
                                                                    if(add_function_value) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                      | func_exp OBRACKET VOID CBRACKET OBRACKET par_list CBRACKET SEMICOLON {
                                                                    add_function_value = add_function($<obj.value>1, ""); 
                                                                    if(add_function_value) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                      
                      | func_exp OBRACKET VOID CBRACKET OBRACKET CBRACKET SEMICOLON {
                                                                    add_function_value = add_function($<obj.value>1, ""); 
                                                                    if(add_function_value) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                      ;

function_definitions : func_exp OBRACKET data_type CBRACKET OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body($<obj.value>1, $<obj.value>3); 
                                                                    if(add_function_value == 2) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": redefinition of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                     
                     | func_exp OBRACKET data_type CBRACKET OBRACKET CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body($<obj.value>1, $<obj.value>3); 
                                                                    if(add_function_value == 2) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": redefinition of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                     | func_exp OBRACKET VOID CBRACKET OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body($<obj.value>1, ""); 
                                                                    if(add_function_value == 2) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": redefinition of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                       
                     | func_exp OBRACKET VOID CBRACKET OBRACKET CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body($<obj.value>1, ""); 
                                                                    if(add_function_value == 2) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": ambiguating new declaration of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      cout << "Semantic Error at Line" << yylineno << ": redefinition of function" << $<obj.value>1 << endl; 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    } 
                     ;

func_exp : ID {
            if (is_variable_declared($<obj.value>1)) {
              cout << "Semantic Error at Line" << yylineno << ": redeclaration of global variable " << $<obj.value>1 << endl; 
            }
            else {
              create_symbol_table();
            }
            }
         ;

par_list : data_type ID COMMA par_list {
                        if (insert_param($<obj.value>2, $<obj.value>1) == 0) {
                          cout << "Semantic Error at Line" << yylineno << ": redeclaration of function parameter " << $<obj.value>1 << endl; 
                        }
                        }
         | data_type ID {
                        if (insert_param($<obj.value>2, $<obj.value>1) == 0) {
                          cout << "Semantic Error at Line" << yylineno << ": redeclaration of function parameter " << $<obj.value>1 << endl; 
                        }
                        }
         ;

stmt : scope_inc stmt scope_dec stmt
     | conditional_stmt stmt
     | loop_stmt stmt 
     | exp_stmt stmt
     | dec_stmt stmt
     | print_stmt stmt
     | input_stmt stmt
     | call stmt
     | R stmt
     | BREAK SEMICOLON stmt
     | CONTINUE SEMICOLON stmt
     | /*empty*/
     ;

conditional_stmt : IF while_body scope_inc stmt scope_dec elif_stmt  
                 ;
                           
elif_stmt : ELIF while_body scope_inc stmt scope_dec elif_stmt
          | else_stmt
          ;

else_stmt : ELSE scope_inc stmt scope_dec
          | /*empty*/
          ;

loop_stmt : WHILE while_body scope_inc stmt scope_dec
          | FOR OBRACKET for_body_1 stmt scope_dec
          | FOR for_body_2 OFLOWER stmt scope_dec
          ; 

while_body : OBRACKET conditional_exp CBRACKET {
                if(!(type_checking("bool",$<obj.eletype>2))){
                  cout << "Semantic Error at Line" << yylineno << ": expected rhs of type: bool" << endl;
                }
                }
           ;

for_body_1 : initialize_exp  for_body_1_a SEMICOLON increment_exp CBRACKET scope_inc
           ;
