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
                if(!(type_checking("bool",charptr_to_string($<obj.value>2)))){
                  printf("Semantic Error at Line %d: expected rhs of type: bool", yylineno);
                }
                }
           ;

for_body_1 : for_body_1_a SEMICOLON increment_exp CBRACKET scope_inc
           ;

for_body_1_a : initialize_exp conditional_exp {
                if(!(type_checking("bool",charptr_to_string($<obj.value>2)))){
                  printf("Semantic Error at Line %d: expected rhs of type: bool", yylineno);
                }
                }
             ;

for_body_2 : for_exp data_type dec_assign for_body_2_a for_body_2_b SEMICOLON increment_exp CBRACKET
           | for_exp data_type id_1 COLON id_2 CBRACKET
           ;

for_body_2_a : SEMICOLON{eletype = charptr_to_string("");}
             ;

for_body_2_b : conditional_exp{
                if(!(type_checking("bool",charptr_to_string($<obj.value>1)))){
                  printf("Semantic Error at Line %d: expected rhs of type: bool", yylineno);
                }
                }
             ;

id_1 : ID {
        if(add_variable(charptr_to_string($<obj.value>1))){
          printf("Semantic Error at Line %d : redeclaration of variable %s\n", yylineno, $<obj.value>1);
        }
        strcpy($<obj.value>$, string_to_char(get_type(charptr_to_string($<obj.value>1))));
        }
     ;

id_2 : ID {
        if(!(is_variable_declared(charptr_to_string($<obj.value>1)))){
          printf("Semantic Error at Line %d : undefined variable %s\n", yylineno, $<obj.value>1);
        }
        }
     ;
