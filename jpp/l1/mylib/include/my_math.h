#ifndef __MY_MATH_H__
#define __MY_MATH_H__

int c_factorial(int n);

/* calculates greatest common denominator of a & b */
int gtc(int a, int b);

typedef struct {
  int x, y;
} int_pair;

/* solves diophantic equation ax + by = c and returns
solution in new int_pair or NULL if no sollution exist,
or if a == b == 0 */
int_pair* solve_equation(int a, int b, int c);

void used_version();

/* Needed for python wrapper */
void free_int_pair(int_pair* p);

#endif // __MY_MATH_H__