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
