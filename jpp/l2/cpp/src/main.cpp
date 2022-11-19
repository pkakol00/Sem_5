#include <iostream>
#include "finite_field.h"
#include "math_util.h"
#include <cassert>

void test_compare() {
  assert(FiniteField(2) == FiniteField(2));
  assert(FiniteField(2) < FiniteField(3));
  assert(!(FiniteField(2) > FiniteField(3)));
}

void test_add() {
  assert(FiniteField(2) + FiniteField(-1) == FiniteField(1));
  assert(FiniteField(2) - FiniteField(3) == FiniteField(-1));
}

void test_mlt() {
  assert(FiniteField(3) * FiniteField(5) == FiniteField(15));
  assert(FiniteField(1) / FiniteField(3) == FiniteField(823045261));
  bool exception_thrown = false;
  try {
    // print so that it won't be optimised away
    std::cout << FiniteField(1) / FiniteField(0);
  } catch(const std::exception& e) {
    exception_thrown = true;
  }
  assert((exception_thrown) && "Exception not thrown");
}

void test_pow() {
  assert(FiniteField(2) ^ 5 == FiniteField(32));
  assert(FiniteField(2) ^ 0 == FiniteField(1));
}

int main(int, char**) {
  test_compare();
  test_add();
  test_mlt();
  test_pow();
  return 0;
}