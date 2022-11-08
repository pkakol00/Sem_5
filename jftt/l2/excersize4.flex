%option reentrant noyywrap

  #include <malloc.h>
  #include <string.h>
  #include <stdlib.h>

  typedef struct {
    int current_size, max_size;
    int* data;
  } stack;

  stack* get_stack(int n) {
    stack* st = malloc(sizeof(stack));
    st->data = malloc(sizeof(int) * n);
    st->current_size = 0;
    st->max_size = n;
    return st;
  }

  int pop_stack(stack* st) {
    return st->data[--st->current_size];
  }

  int push_stack(stack* st, int v) {
    if (st->current_size == st->max_size) {
      int* new_data = malloc(sizeof(int) * st->max_size * 2);
      memcpy(new_data, st->data, st->max_size);
      free(st->data);
      st->data = new_data;
    }
    st->data[st->current_size ++] = v;
  }
  
  void free_stack(stack* st) {
    free(st->data);
    free(st);
  }

  int powi(int base, int exponent) {
    int res = 1;
    while (exponent--  > 0) res *= base;
    return res;
  }


  stack* st;
  int res = 0;
  int not_error_state = 1;
  char* error_msg_buffer[512];

  void error(const char* error_message) {
    sprintf(error_msg_buffer, "\n\t%s", error_message);
    not_error_state = 0;
  }

%{

#define CALCULATE( OP ) { \
  yyecho();\
  if (not_error_state) { \
    if (st->current_size < 2) { \
      error("Too few operands\n"); \
    } else { \
      int a = pop_stack(st), b = pop_stack(st);\
      push_stack(st, b OP a); \
    } \
  } \
}

//TOOO JFTT zadanie 3

#define CALCULATE_DIV( OP ) { \
  yyecho();\
  if (not_error_state) { \
    if (st->current_size < 2) { \
      error("Too few operands\n"); \
    } else { \
      int a = pop_stack(st), b = pop_stack(st); \
      if (a) { \
        push_stack(st, b OP a); \
      } else { \
        error("Devision by 0 error\n"); \
      } \
    } \
  }\
}

%}

%%

%{
  void calculate_pow() {
    yyecho();
    if(not_error_state) {
      if (st->current_size < 2) { 
        error("Too few operands\n");
      } else { 
        push_stack(st, powi(pop_stack(st), pop_stack(st)));
      } 
    }
  }

%}

"-"?[[:digit:]]+ {
  push_stack(st, atoi(yytext)); yyecho();
}
"+" CALCULATE( + )
"-" CALCULATE( - )
"*" CALCULATE( * )
"/" CALCULATE_DIV( / )
"%" CALCULATE_DIV( % )
"^" calculate_pow();
[^1-9+\-*/\^\n ] error("Invalid character\n");

\n {
  if (st->current_size != 1) {
    error("Too few operators\n");
  } 
  if (not_error_state) {
    printf("\n\t= %d\n", pop_stack(st));
  } else {
    printf("%s", error_msg_buffer);
  }
  st->current_size = 0;
}

%% 
int main(int argc, char** argv) {
  yyscan_t scanner;
  st = get_stack(32);
  yylex_init ( &scanner );
  yylex ( scanner );
  yylex_destroy ( scanner );
  free_stack(st);
}