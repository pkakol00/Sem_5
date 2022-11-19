#!/usr/bin/env python3

import pytest

from finite_field import *

def test_compare():
  assert FiniteField(12) > FiniteField(10)
  assert not FiniteField(12) < FiniteField(10)
  assert FiniteField(12) == FiniteField(12)

def test_add():
  assert FiniteField(2) + FiniteField(-1) == FiniteField(1)
  assert FiniteField(2) - FiniteField(3) == FiniteField(-1)

def test_mlt():
  assert FiniteField(3) * FiniteField(5) == FiniteField(15)
  assert FiniteField(1) / FiniteField(3) == FiniteField(823045261)
  with pytest.raises(Exception):
    FiniteField(1) / FiniteField(0)

def test_pow():
  assert FiniteField(2) ** 5 == FiniteField(32)
  assert FiniteField(2) ** 0 == FiniteField(1)

if __name__ == "__main__":
  print(FiniteField(16) * FiniteField(14))
  print(FiniteField(1) / FiniteField(3))
  print(FiniteField(1) > FiniteField(3))
  print(FiniteField(1) < FiniteField(3))
  print(FiniteField(3) ** -1)