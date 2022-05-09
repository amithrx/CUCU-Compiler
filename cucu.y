%{
 #include <stdio.h>
 #include <string.h>
  FILE *out;
  extern FILE *yyin,*yyout;
%}

%union{
    int num;
    char *string;
}

%token KEYWORDS SEMI COMMA OPEN_CURLY CLOSED_CURLY OPEN_ROUND CLOSED_ROUND OPEN_SQUARE CLOSED_SQUARE ASSIGN RELATIONAL_OPERATOR PLUS MINUS MUL DIV EQ NEQ GT LT GEQ LEQ AND
%token <string> TYPE
%token <string> IF
%token <string> ELSE
%token <string> WHILE
%token <string> RETURN
%token <string> IDENTIFIER
%token <num> NUM


%%
program :  var_decl | func_decl | func_def ;
var_decl : TYPE IDENTIFIER SEMI program{fprintf(out,"Variable declared : %s , Type : %s\n",$2,$1);};
           |TYPE IDENTIFIER SEMI {fprintf(out,"Local Variable : %s , Type : %s\n",$2,$1);};
           |TYPE expr SEMI program{fprintf(out,"Type : %s\n",$1);}
           |TYPE expr SEMI {fprintf(out,"Type : %s\n",$1);};
func_decl : TYPE IDENTIFIER OPEN_ROUND func_args CLOSED_ROUND SEMI program{fprintf(out,"Function declared : %s , return type : %s\n",$2,$1);};
func_def : TYPE IDENTIFIER OPEN_ROUND CLOSED_ROUND OPEN_CURLY func_body CLOSED_CURLY program{fprintf(out,"Function defined : %s , return type : %s\n",$2,$1);}
           |TYPE IDENTIFIER OPEN_ROUND CLOSED_ROUND OPEN_CURLY func_body CLOSED_CURLY{fprintf(out,"Function defined : %s , return type : %s\n",$2,$1);}
           |TYPE IDENTIFIER OPEN_ROUND func_args CLOSED_ROUND OPEN_CURLY func_body CLOSED_CURLY program{fprintf(out,"Function defined : %s , return type : %s\n",$2,$1);};
           |TYPE IDENTIFIER OPEN_ROUND func_args CLOSED_ROUND OPEN_CURLY CLOSED_CURLY {fprintf(out,"Function defined : %s , return type : %s\n",$2,$1);};
           |TYPE IDENTIFIER OPEN_ROUND  CLOSED_ROUND OPEN_CURLY  CLOSED_CURLY program{fprintf(out,"Function defined : %s , return type : %s\n",$2,$1);};;
func_args :  TYPE IDENTIFIER COMMA func_args {fprintf(out,"Function arguments : %s , Type : %s\n",$2,$1);}
             |TYPE IDENTIFIER  {fprintf(out,"Function arguments : %s , Type : %s\n",$2,$1);};
func_body : statements;
statements : statements statement | statement;
statement :     IDENTIFIER SEMI  {fprintf(out,"Variable : %s\n",$1);}
                |IDENTIFIER ASSIGN expr SEMI  {fprintf(out,"Variable : %s = ",$1);}
                |TYPE IDENTIFIER SEMI  {fprintf(out,"Local variable : %s , Type : %s\n",$2,$1);}
                |TYPE IDENTIFIER ASSIGN expr SEMI  {fprintf(out,"Local variable : %s , Type : %s = ",$2,$1);}
                |RETURN expr   {fprintf(out,"Keywords : %s\n",$1);}
                |IF OPEN_ROUND expr CLOSED_ROUND OPEN_CURLY statements CLOSED_CURLY{fprintf(out,"Keywords : %s\n",$1);}
                |IF OPEN_ROUND expr CLOSED_ROUND OPEN_CURLY statements CLOSED_CURLY ELSE OPEN_CURLY statements CLOSED_CURLY{fprintf(out,"Keywords : %s , Keywords : %s\n",$1,$8);}
                | WHILE OPEN_ROUND expr CLOSED_ROUND OPEN_CURLY statements CLOSED_CURLY{fprintf(out,"Keywords : %s\n",$1);}
                | IDENTIFIER OPEN_ROUND CLOSED_ROUND SEMI {fprintf(out,"Identifier : %s\n",$1);}
                |IDENTIFIER OPEN_ROUND expr CLOSED_ROUND SEMI {fprintf(out,"Identifier : %s\n",$1);}
                |IDENTIFIER OPEN_ROUND call_args CLOSED_ROUND SEMI {fprintf(out,"Function called : %s\n",$1);}
                | expr SEMI
                | RETURN IDENTIFIER SEMI {fprintf(out,"Keywords : %s , Identifier : %s\n",$1,$2);}
                | RETURN SEMI {fprintf(out,"Keywords : %s\n",$1);}
                | RETURN expr SEMI {fprintf(out,"Keywords : %s\n",$1);}
                |TYPE IDENTIFIER OPEN_SQUARE expr CLOSED_SQUARE SEMI  {fprintf(out,"Variable : %s , Type : %s\n",$2,$1);}
                | ;
call_args :     IDENTIFIER COMMA call_args {fprintf(out,"Function arguments : %s\n",$1);}
                | IDENTIFIER {fprintf(out,"Function arguments : %s\n",$1);}
                | NUM COMMA call_args {fprintf(out,"Function arguments : %d\n",$1);}
                | NUM {fprintf(out,"Function arguments : %d\n",$1);}
                | IDENTIFIER OPEN_SQUARE expr CLOSED_SQUARE COMMA call_args {fprintf(out,"Function arguments : %s\n",$1);}
                | IDENTIFIER OPEN_SQUARE expr CLOSED_SQUARE {fprintf(out,"Function arguments : %s\n",$1);}
expr : eq_expr 
           | IDENTIFIER ASSIGN expr {fprintf(out,"Identifier : %s\n",$1);};
eq_expr : rel_expr
              | eq_expr EQ rel_expr {fprintf(out," == ");};
              | eq_expr NEQ rel_expr {fprintf(out," != ");};
              | eq_expr GT rel_expr {fprintf(out," > ");};
              | eq_expr LT rel_expr {fprintf(out," < ");};
              | eq_expr GEQ rel_expr {fprintf(out," >= ");};
              | eq_expr LEQ rel_expr {fprintf(out," <= ");};;
rel_expr : rel_expr PLUS term {fprintf(out," + ");};
           | rel_expr MINUS term {fprintf(out," - ");};
           | term ;
term : term MUL factorr {fprintf(out," * ");};
       | term DIV factorr {fprintf(out," / ");};
       | factorr ;
factorr : factorr AND factor {fprintf(out," & ");};
         | factor
factor : IDENTIFIER {fprintf(out,"Identifier : %s\n",$1);}
          | NUM {fprintf(out,"Const : %d\n",$1);}
          | OPEN_ROUND rel_expr CLOSED_ROUND;
%%

  void yyerror( char *str)
{
    fclose(yyout);
    fclose(out);
    yyout = fopen("Lexer.txt","w");
    fprintf(yyout,"error encounterd\n");
    out = fopen("Parser.txt","w");
    fprintf(out,"error encounterd\n");
    fprintf(stderr,"error: %s\n",str);
}

 int yywrap()
 {
     return 1;
 }


main(int argc[], char *argv[])
{
    yyin = fopen(argv[1],"r");
    yyout = fopen("Lexer.txt","w");
    out = fopen("Parser.txt","w");
    yyparse();
}