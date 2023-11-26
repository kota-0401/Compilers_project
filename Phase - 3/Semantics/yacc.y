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
