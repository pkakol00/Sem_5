from mylib import recursive
from mylib import iterative
from mylib import c_wrapper

if __name__ == "__main__":
  print(recursive.factorial(5))
  print(recursive.GCD(14, 12))
  x, y = recursive.solve_equation(12, 7, 34)
  print(12 * x + 7 * y == 34)

  print(iterative.factorial(5))
  print(iterative.GCD(12 ,14))
  x, y = iterative.solve_equation(12, 7, 34)
  print(12 * x + 7 * y == 34)

  print("version c wrapper")

  print(c_wrapper.factorial(5))
  print(c_wrapper.GCD(12 ,14))
  x, y = c_wrapper.solve_equation(12, 7, 34)
  print(12 * x + 7 * y == 34)
