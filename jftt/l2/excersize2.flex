%option reentrant noyywrap
%x REMOVE
%x MULTILINE_STRING
%x SOFT_MULTILINE_STRING
/* INITIAL is treated as DONT_REMOVE */
/* separete REMOVE state is required since othewise #[[:print]]* could match
a longer sequence then a inline string and thus capture comment inside it */
%%
<REMOVE,INITIAL>[[:blank:]]*# yybegin(REMOVE);
<REMOVE>"\n" yybegin(INITIAL);
<REMOVE>[^\n]
<INITIAL>''' yybegin(MULTILINE_STRING); yyecho();
<MULTILINE_STRING>''' yybegin(INITIAL); yyecho();
<INITIAL>\"\"\" yybegin(MULTILINE_STRING); yyecho();
<MULTILINE_STRING>\"\"\" yybegin(INITIAL); yyecho();
<INITIAL>'[^'\n\\]*' yyecho();
<INITIAL>\"\\\n yybegin(SOFT_MULTILINE_STRING); yyecho();
<INITIAL>'\\\n yybegin(SOFT_MULTILINE_STRING); yyecho();
<SOFT_MULTILINE_STRING>"\n" yyecho();yybegin(INITIAL);
<SOFT_MULTILINE_STRING>"\\\n" yyecho(); 
<SOFT_MULTILINE_STRING>[^\\\n] yyecho();

%% 
int main() {
  yyscan_t scanner;
  yylex_init ( &scanner );
  yylex ( scanner );
  yylex_destroy ( scanner );
}