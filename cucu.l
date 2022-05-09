%{
#include <stdio.h>
#include <string.h>
//#include "y.tab.h"
#include "cucu.tab.h"
#define YYSTYPE char *
%}

%%
int[ ]|char[ ][*] {fprintf(yyout,"Type : %s\n",yytext);yylval.string=strdup(yytext); return TYPE;}; 
if {fprintf(yyout,"Keywords : %s\n",yytext);yylval.string=strdup(yytext);return IF;};
else {fprintf(yyout,"Keywords : %s\n",yytext);yylval.string=strdup(yytext);return ELSE;};
while {fprintf(yyout,"Keywords : %s\n",yytext);yylval.string=strdup(yytext);return WHILE;};
return {fprintf(yyout,"Keywords : %s\n",yytext);yylval.string=strdup(yytext);return RETURN;};
[a-zA-Z_]+[a-zA-Z0-9]* {fprintf(yyout,"Identifier : %s\n",yytext);yylval.string=strdup(yytext);return IDENTIFIER;};            
[;] {fprintf(yyout,"Semicolon : %s\n",yytext);return SEMI;};
[,] {fprintf(yyout,"Comma : %s\n",yytext);return COMMA;};
[(] {fprintf(yyout,"Open_Round_Brackets : %s\n",yytext);return OPEN_ROUND;};
[{] {fprintf(yyout,"Open_Curly_Brackets : %s\n",yytext);return OPEN_CURLY;};
[[] {fprintf(yyout,"Open_Square_Brackets : %s\n",yytext);return OPEN_SQUARE;};
[)] {fprintf(yyout,"Closed_Round_Brackets : %s\n",yytext);return CLOSED_ROUND;};
[}] {fprintf(yyout,"Closed_Curly_Brackets : %s\n",yytext);return CLOSED_CURLY;};
[\]] {fprintf(yyout,"Closed_Square_Brackets : %s\n",yytext);return CLOSED_SQUARE;};
[ ]+ ;
[=] {fprintf(yyout,"Assign : %s\n",yytext);return ASSIGN;};
[0-9]+ {fprintf(yyout,"Constant : %s\n",yytext);yylval.num=atoi(yytext);return NUM;};
[=][=] {fprintf(yyout,"Is_Equal : %s\n",yytext);return EQ;};
[!][=] {fprintf(yyout,"Is_Not_Equal : %s\n",yytext);return NEQ;};
[>] {fprintf(yyout,"Greater than : %s\n",yytext);return GT;};
[>][=] {fprintf(yyout,"Greater than or equals to : %s\n",yytext);return GEQ;};
[<] {fprintf(yyout,"Less than : %s\n",yytext);return LT;};
[<][=] {fprintf(yyout,"Less than or equal to : %s\n",yytext);return LEQ;};
[&] {fprintf(yyout,"And : %s\n",yytext);return AND;};
[+] {fprintf(yyout,"Plus : %s\n",yytext);return PLUS;};
[-] {fprintf(yyout,"Minus : %s\n",yytext);return MINUS;};
[*] {fprintf(yyout,"Mul : %s\n",yytext);return MUL;};
[/] {fprintf(yyout,"Div : %s\n",yytext);return DIV;};
(\/\*([^*]|\n)*\*\/) {};
\/\/.* {};
. {yyerror("Invalid character");}
%%

