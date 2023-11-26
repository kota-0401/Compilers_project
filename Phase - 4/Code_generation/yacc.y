%%
/*productions*/
S : function_declarations S
  | function_definitions S
  | dec_stmt S 
  | /*empty*/{}
  ;

function_declarations : func_exp OBRACKET data_type CBRACKET OBRACKET par_list CBRACKET SEMICOLON {
                                                                    add_function_value = add_function(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1); 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }
                      | func_exp OBRACKET data_type CBRACKET OBRACKET CBRACKET SEMICOLON {
                                                                    add_function_value = add_function(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1); 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                      | func_exp OBRACKET VOID CBRACKET OBRACKET par_list CBRACKET SEMICOLON {
                                                                    add_function_value = add_function(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1); 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                      
                      | func_exp OBRACKET VOID CBRACKET OBRACKET CBRACKET SEMICOLON {
                                                                    add_function_value = add_function(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1); 
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                      ;

function_definitions : func_exp OBRACKET data_type CBRACKET OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value == 2) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1);
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      printf("Semantic Error at Line %d: redefinition of function %s\n", yylineno, $<obj.value>1);  
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                     
                     | func_exp OBRACKET data_type CBRACKET OBRACKET CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value == 2) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1);
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      printf("Semantic Error at Line %d: redefinition of function %s\n", yylineno, $<obj.value>1);  
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    }                      
                     | func_exp OBRACKET VOID CBRACKET OBRACKET par_list CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value == 2) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1);
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      printf("Semantic Error at Line %d: redefinition of function %s\n", yylineno, $<obj.value>1);  
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    param_list.clear();
                                                                    delete_symbol_table();
                                                                    }                       
                     | func_exp OBRACKET VOID CBRACKET OBRACKET CBRACKET OFLOWER stmt CFLOWER {
                                                                    add_function_value = add_function_body(charptr_to_string($<obj.value>1), charptr_to_string($<obj.value>3)); 
                                                                    if(add_function_value == 2) {
                                                                      printf("Semantic Error at Line %d: ambiguating new declaration of function %s\n", yylineno, $<obj.value>1);
                                                                    } 
                                                                    else if(add_function_value == 0) {
                                                                      printf("Semantic Error at Line %d: redefinition of function %s\n", yylineno, $<obj.value>1);  
                                                                    } 
                                                                    add_function_value = 0; 
                                                                    delete_symbol_table();
                                                                    } 
                     ;

func_exp : ID {
            if (is_variable_declared(charptr_to_string($<obj.value>1))) {
              printf("Semantic Error at Line %d: redeclaration of global variable %s\n",yylineno, $<obj.value>1); 
            }
            else {
              create_symbol_table();
              strcpy($<obj.value>$, $<obj.value>1);
            }
            }
         ;

par_list : data_type ID COMMA par_list {
                        if (insert_param(charptr_to_string($<obj.value>2), charptr_to_string($<obj.value>2)) == 0) {
                          printf("Semantic Error at Line %d: redeclaration of function parameter %s\n", yylineno, $<obj.value>2); 
                        }
                        }
         | data_type ID {
                        if (insert_param(charptr_to_string($<obj.value>2), charptr_to_string($<obj.value>2)) == 0) {
                          printf("Semantic Error at Line %d: redeclaration of function parameter %s\n", yylineno, $<obj.value>2); 
                        }
                        }
         ;
