#ifndef __MATH_UTIL_H__
#define __MATH_UTIL_H__

#include <math.h>
#include <optional>

typedef std::pair<long int, long int> int_pair;

inline long int ext_euclidian(long int a, long int b, long int* x, long int* y) {
  *x = 1, *y = 0;
  long int x1 = 0, y1 = 1, a1 = a, b1 = b;
  while (b1) {
    long int q = a1 / b1;
    
    long int c = *x; // auxilary variable
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

inline std::optional<int_pair> solve_equation(long int a, long int b, long int c) {
  if (!(a || b)) return {};
  long int x0, y0;
  long int g = ext_euclidian(std::abs(a), std::abs(b), &x0, &y0);
  if (c % g != 0) return {};

  x0 *= ((a > 0) ? c / g : -c / g);
  y0 *= ((b > 0) ? c / g : -c / g);

  return int_pair(x0, y0);
}

#endif // __MATH_UTIL_H__