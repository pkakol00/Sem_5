%option reentrant noyywrap
%option reject
  int line_count = 0;
  #include <stdio.h>
%%
^[[:blank:]]+
[[:blank:]]+$
[[:blank:]]+/\<<EOF>>
[[:blank:]]+ putchar(' ');
\n[[:blank:]]*$
\n[[:blank:]]*/\<<EOF>>
^([[:blank:]]*[[:print:]]+[[:blank:]]*)+\n {
  line_count ++; yyreject();
}
^([[:blank:]]*[[:print:]]+[[:blank:]]*)+/\<<EOF>> { 
  line_count ++; yyreject();
}

%% 

int main() {
  yyscan_t scanner;
  yylex_init ( &scanner );
  yylex ( scanner );
  yylex_destroy ( scanner );
  fprintf(stderr, "Line count: %d\n", line_count);
}