#ifndef __FINITE_FIELD_H__
#define __FINITE_FIELD_H__

#include <iostream>

class FiniteField {
private:
  long int value_;
public:
  const static long int size = 1234567891;

  FiniteField();
  FiniteField(long int value);
  FiniteField(const FiniteField& other);

  long int getValue() const;
  void setValue(const long int& v);

  // arithmetic operators
  FiniteField operator+ (const FiniteField& f) const;
  FiniteField operator- (const FiniteField& f) const;
  FiniteField operator* (const FiniteField& f) const;
  FiniteField operator/ (const FiniteField& f) const;
  FiniteField operator^ (int f) const;
  FiniteField operator- () const;

  // logical operators
  bool operator== (const FiniteField& f) const;
  bool operator< (const FiniteField& f) const;
  bool operator> (const FiniteField& f) const;
  bool operator<= (const FiniteField& f) const; 
  bool operator>= (const FiniteField& f) const;

  // copy operator
  FiniteField& operator= (const FiniteField& f);

  // casts
  operator int() const;

  friend std::ostream& operator<< (std::ostream& os, const FiniteField& f);
};

#endif // __FINITE_FIELD_H__