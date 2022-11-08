%option reentrant noyywrap
  int remove_doxygen_coments = 1;
  int is_inside_doxygen_comment = 0;
%x MULTILINE_COMMENT
%x DOXYGEN_COMMENT
/* INITIAL is treated as DONT_REMOVE */
/* separete REMOVE state is required since othewise #[[:print]]* could match
a longer sequence then a inline string and thus capture comment inside it */
%%

<INITIAL>"/**".*"*/"\n {
  if (!remove_doxygen_coments) yyecho();
}
<INITIAL>"///".*\n if (!remove_doxygen_coments) yyecho();
<INITIAL>"//!".*\n if (!remove_doxygen_coments) yyecho();
<INITIAL>"#include".* yyecho();

<INITIAL>"/*" {yybegin(MULTILINE_COMMENT); is_inside_doxygen_comment = 0;}
<INITIAL>"/*!" {
    if (remove_doxygen_coments) {
      yybegin(MULTILINE_COMMENT);
      is_inside_doxygen_comment = 0;
    } else {
      yybegin(DOXYGEN_COMMENT);
      is_inside_doxygen_comment = 1;
      yyecho();
    } 
  }
<MULTILINE_COMMENT,DOXYGEN_COMMENT>"*/" {
    if(is_inside_doxygen_comment){
      yyecho();
      is_inside_doxygen_comment = 0;
    }
    yybegin(INITIAL);
  }
<MULTILINE_COMMENT,DOXYGEN_COMMENT>"*/\n" {
    if(is_inside_doxygen_comment){
      yyecho();
      is_inside_doxygen_comment = 0;
    }
    yybegin(INITIAL);
  }

<MULTILINE_COMMENT>.|\n
<INITIAL>\"[[:print:]]*\" yyecho();
<INITIAL>[[:blank:]]*("//"|"/\\\n/")([[:print:]]*"\\\n")*[[:print:]]*\n 

%% 
int main(int argc, char** argv) {
  for (int i = 0; i < argc; i ++ ) {
    if (strcmp("--dox", argv[i]) == 0) {
      remove_doxygen_coments = 0;
    }
  }
  yyscan_t scanner;
  yylex_init ( &scanner );
  yylex ( scanner );
  yylex_destroy ( scanner );
}