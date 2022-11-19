package com.finite_field;

import com.finite_field.MathUtil;

public class FiniteField implements Comparable<FiniteField>{
  private Long value_;
  public static final Long size = 1234567891L;

  public Long getValue() {
    return value_;
  }

  public void setValue(Long v) {
    value_ = v;
  }

  public FiniteField(Long v) {
    value_ = (size + v) % size;
  }

  public FiniteField() {
    value_ = 0L;
  }

  @Override
  public String toString() {
    return String.format("(%d)", value_);
  }

  @Override
  public boolean equals(Object o) {
    if (o == this) return true;
    if (!(o instanceof FiniteField)) return false;
    return ((FiniteField)o).value_.equals(value_);
  }

  @Override
  public int compareTo(FiniteField f) {
    return Long.compare(value_, f.value_);
  }

  public static FiniteField add(FiniteField a, FiniteField b) {
    return new FiniteField(a.value_ + b.value_);
  }

  public static FiniteField sbstr(FiniteField a, FiniteField b) {
    return new FiniteField(FiniteField.size + a.value_ - b.value_);
  }

  public static FiniteField mlt(FiniteField a, FiniteField b) {
    return new FiniteField(a.value_ * b.value_);
  }

  public static FiniteField div(FiniteField a, FiniteField b) throws Exception {
    if (b.value_ == 0) {
      throw new Exception("Division by 0");
    }
    Long b_inverted = MathUtil.solveEquation(b.value_, FiniteField.size, 1L).x;
    return FiniteField.mlt(a, new FiniteField(b_inverted));
  }

  public static FiniteField neg(FiniteField a) {
    return new FiniteField(-a.value_);
  }

  public static FiniteField pow(FiniteField a, FiniteField b) {
    if (b.value_ == 0) return new FiniteField(1L);
    Long acc = 1L, cnt = b.value_;
    while (cnt > 0) {
      acc = (acc * a.value_) % FiniteField.size;
      cnt --;
    }
    return new FiniteField(acc);
  }
}
