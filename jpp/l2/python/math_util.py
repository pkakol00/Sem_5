def ext_euclidian(a: int, b: int) -> tuple:
  x = 1
  y = 0
  x1 = 0
  y1 = 1
  while b != 0:
    q = a // b
    x, x1 = x1, x - q * x1
    y, y1 = y1, y - q * y1
    a, b = b, a - q * b
  return (x, y, a)

def solve_equation(a: int, b: int, c: int) -> tuple:
  if a == 0 and b == 0: return None
  x0, y0, g = ext_euclidian(abs(a), abs(b))
  if c % g != 0: return None

  x0 *= (c // g if a > 0 else - c // g)
  y0 *= (c // g if b > 0 else - c // g)
  return (x0, y0)