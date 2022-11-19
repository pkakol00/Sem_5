#include "finite_field.h"
#include "math_util.h"
#include <stdexcept>

FiniteField::FiniteField() : value_(0) {};

FiniteField::FiniteField(long int value) : value_((value + size) % size) {};

FiniteField::FiniteField(const FiniteField& other) 
  : value_((other.value_ + size) % size) {};

long int FiniteField::getValue() const {
  return value_;
}
void FiniteField::setValue(const long int& v) {
  value_ = v;
}

FiniteField FiniteField::operator+ (const FiniteField& f) const {
  return FiniteField((f.value_ + value_) % size);
}

FiniteField FiniteField::operator- (const FiniteField& f) const {
  return FiniteField((value_ - f.value_ + size) % size);
}

FiniteField FiniteField::operator* (const FiniteField& f) const {
  return FiniteField((value_ * f.value_) % size);
}

FiniteField FiniteField::operator/ (const FiniteField& f) const {
  if (!f) throw std::invalid_argument("Division by 0");
  long int f_inverted = solve_equation(f, size, 1).value().first % size;
  return FiniteField((value_ * f_inverted) % size);
}

FiniteField FiniteField::operator^ (int f) const {
  if (f < 0) return FiniteField(1) / (*this ^ (-f));
  long long int ack = 1;
  while (f) {
    ack = (ack * value_) % size;
    f--;
  }
  return FiniteField(ack);
}

FiniteField FiniteField::operator- () const {
  return FiniteField((size - value_) % size);
}

bool FiniteField::operator== (const FiniteField& f) const {
  return f.value_ == value_;
}

bool FiniteField::operator< (const FiniteField& f) const {
  return value_ < f.value_;
}

bool FiniteField::operator> (const FiniteField& f) const {
  return value_ > f.value_;
}

bool FiniteField::operator<= (const FiniteField& f) const {
  return value_ <= f.value_;
}

bool FiniteField::operator>= (const FiniteField& f) const {
  return value_ >= f.value_;
}

FiniteField& FiniteField::operator= (const FiniteField& f) {
  value_ = f.value_;
  return *this;
}

FiniteField::operator int() const {
  return value_;
}

std::ostream& operator<< (std::ostream& os, const FiniteField& f) {
  os << "(" << f.value_ << ")";
  return os;
}
