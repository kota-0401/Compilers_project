yacc -d -v yacc.y;
lex lexer.l;
g++ -g y.tab.c lex.yy.c -o src;
./src
