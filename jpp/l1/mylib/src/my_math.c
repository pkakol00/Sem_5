#include "my_math.h"
#include <malloc.h>
#include <stdio.h>

// #define RECURSIVE_IMPLEMENTATION 
#ifdef RECURSIVE_IMPLEMENTATION

int factorial(int n) {
  return n <= 1 ? 1 :  n * factorial(n - 1);
}

// assuming a & b != 0, a >= b 
int gtc_propper(int a, int b) {
  if (!a) return b;
  if (!b) return a;
  return gtc_propper(b, a % b);
}

int ext_euclidian(int a, int b, int* x, int* y) {
  if (!b) {
    *x = 1;
    *y = 0;
    return a;
  }
  int x1, y1;
  int d = ext_euclidian(b, a % b, &x1, &y1);
  *x = y1;
  *y = x1 - y1 * (a / b);
  return d; 
}

void used_version() {
  printf("version recursive\n");
}

#elif defined ADA_WRAPPER

extern int ada_factorial(int n);
int factorial(int n) {
  return ada_factorial(n);
}

extern int ada_gcd(int a, int b);
int gtc_propper(int a, int b) {
  return ada_gcd(a, b);
}

void used_version() {
  printf("version ada wrapper\n");
}

#else

int factorial(int n) {
  if (n <= 1) {
    return 1;
  } else {
    int accumulator = 1;
    while (n != 1) {
      accumulator *= (n --);
    }
    return accumulator;
  }
}

int gtc_propper(int a, int b) {
  while (1) {
    if (!a) return b;
    if (!b) return a;
    int c = a;
    a = b;
    b = c % b;
  }
}

int ext_euclidian(int a, int b, int* x, int* y) {
  *x = 1, *y = 0;
  int x1 = 0, y1 = 1, a1 = a, b1 = b;
  while (b1) {
    int q = a1 / b1;
    
    int c = *x; // auxilary variable
    *x = x1;
    x1 = c - q * x1;

    c = *y;
    *y = y1;
    y1 = c - q * y1;

    c = a1;
    a1 = b1;
    b1 = c - q * b1;
  }
  return a1;
}

void used_version() {
  printf("version iterative\n");
}

#endif //RECURSIVE_IMPLEMENTATION

int abs(int x) {
  return x > 0 ? x : -x;
}

int gtc(int a, int b) {
  if (!(a | b)) return 1;
  return a > b ? gtc_propper(a, b) : gtc_propper(b, a);
}

void free_int_pair(int_pair* p) {
  free(p);
}

#ifdef ADA_WRAPPER

typedef struct {
  int correct;
  int x, y;
} ada_sollution;

extern ada_sollution* ada_solve_equation(int a, int b, int c);
int_pair* solve_equation(int a, int b, int c) {
  ada_sollution* ada_res = ada_solve_equation(a, b, c);
  if (ada_res->correct) {
    int_pair* pair = (int_pair*) malloc(sizeof(int_pair));
    *pair = (int_pair) {ada_res->x, ada_res->y};
    free(ada_res);
    return pair;
  } else {
    return NULL;
  }
}

#else

int_pair* solve_equation(int a, int b, int c) {
  if (!(a || b)) return NULL;
  int x0, y0;
  int g = ext_euclidian(abs(a), abs(b), &x0, &y0);
  if (c % g != 0) return NULL;

  x0 *= ((a > 0) ? c / g : -c / g);
  y0 *= ((b > 0) ? c / g : -c / g);
  int_pair* pair = (int_pair*) malloc(sizeof(int_pair));
  
  // printf("x: %d y: %d\n", x0, y0);

  // if (a >= b) {
     pair->x = x0;
     pair->y = y0;
  // } else {
  //   pair->y = x0;
  //   pair->x = y0;
  // }
  return pair;
}
#endif // ADA_WRAPPER
