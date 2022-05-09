Instruction and assumptions made in this Lab:
.............................................***************************************************************......................................................................
- To run the program, enter these commands in linux terminal
  flex cucu.l
  bison -d cucu.y
  cc lex.yy.c cucu.tab.c -o cucu
  ./cucu Sample1.cu (for running Sample1.cu input text) | ./cucu Sample2.cu (for running Sample2.cu input text)

.............................................***************************************************************......................................................................
- After this, it would produce two files one is Lexer.txt which contains all the tokens another is Parser.txt which contains information about the variable.
- As a valid syntax only "=" "==" "!=" "+" "-" "*" "/" ">" "<" "%" "&" ">=" "<=" are allowed other mathematical character will show an error.
- Array index is also supported in our compiler. eg. s[i]==4 will not throw an error.
- For declaring a variable or assigning a variable we need to do this in multiple lines. Like int a,b,c=4; will throw an error.
- In if/else/while loop conditions such as only above mathematical characters are considered to be invalid.
- For the return statement both return i; as well as return; are considered valid, as well as return 3+4;
- Ignore the warnings coming onto the console as well as shift/reduce conflicts.
- If it is showing an error on the console, then no need to look into Lexer.txt and Parser.txt because in that it will show a partially parsed tree in Parser.txt.
- If it is not showing an error then we need to look into Lexer.txt as well as Parser.txt.