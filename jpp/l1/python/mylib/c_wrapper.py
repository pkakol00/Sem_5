import ctypes
import pathlib
from traceback import print_tb

class Pair(ctypes.Structure):
  _fields_ = [("x", ctypes.c_int), ("y", ctypes.c_int)]

libname = pathlib.Path().absolute() / "mylib/libmylib_iterative_shared.so"
c_lib = ctypes.CDLL(libname)


def factorial(n: int) -> int:
  return c_lib.factorial(n)

def GCD(a: int, b: int) -> int:
  return c_lib.gtc(a, b)

def solve_equation(a: int, b: int, c: int) -> tuple:
  res_ptr = c_lib.solve_equation(a, b, c)
  if res_ptr:
    res = ctypes.cast(res_ptr, ctypes.POINTER(Pair))
    res = (int(res.contents.x), int(res.contents.y))
    c_lib.free_int_pair(res_ptr)
    return res

if __name__ == '__main__':
  print(factorial(5))
  print(GCD(12, 14))
  print(solve_equation(0, 0, 0))
