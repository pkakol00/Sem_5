def factorial(n: int) -> int:
  return 1 if n <= 1 else n * factorial(n - 1)

def GCD(a: int, b: int) -> int:
  return a if b == 0 else GCD(b, a % b)

def ext_euclidian(a: int, b: int) -> tuple:
  if b == 0: return (1, 0, a)
  else:
    x1, y1, d = ext_euclidian(b , a % b)
    return (y1, x1 - y1 * (a // b), d)

def solve_equation(a: int, b: int, c: int) -> tuple:
  if a == 0 and b == 0: return None
  x0, y0, g = ext_euclidian(abs(a), abs(b))
  if c % g != 0: return None

  x0 *= (c // g if a > 0 else - c // g)
  y0 *= (c // g if b > 0 else - c // g)
  return (x0, y0)
