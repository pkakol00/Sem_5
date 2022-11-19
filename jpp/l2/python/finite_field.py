import math_util

class FiniteField:
  size = 1234567891
  # size = 11
  
  def __init__(self, v: int = 0) -> None:
    self.value = (v + FiniteField.size) % FiniteField.size

  def __str__(self) -> str:
    return "({})".format(self.value)

  def __add__(self, other):
    return FiniteField(self.value + other.value)
  
  def __sub__(self, other):
    return FiniteField(self.value - other.value + FiniteField.size)
  
  def __mul__(self, other):
    return FiniteField(self.value * other.value)

  def __truediv__(self, other):
    if (other == FiniteField(0)): raise Exception('Division by 0')
    ohter_inverted = math_util.solve_equation(other.value, 
      FiniteField.size, 1)[0] % FiniteField.size
    return FiniteField(self.value * ohter_inverted)
  
  def __pow__(self, other):
    exponent = other.value if isinstance(other, FiniteField) else other
    if exponent < 0: return FiniteField(1) / self**(-exponent)
    else:
      acc = 1
      while exponent > 0:
        acc = (acc * self.value) % FiniteField.size
        exponent -= 1
      return FiniteField(acc)

  def __eq__(self, __o: object) -> bool:
    return self.value == __o.value

  def __lt__(self, other) -> bool:
    return self.value < other.value

  def __gt__(self, other) -> bool:
    return self.value > other.value