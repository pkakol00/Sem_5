package com.finite_field;

import java.lang.Math;

public class MathUtil {
  public static class Triplet<A, B, C> {
    public A x;
    public B y;
    public C z;

    public Triplet(A a, B b, C c) {
      x = a;
      y = b;
      z = c;
    } 
  }

  public static class Pair<A, B> {
    public A x;
    public B y;

    public Pair(A a, B b) {
      x = a;
      y = b;
    }
    
    @Override
    public String toString() {
      return String.format("(%d, %d)", x, y);
    }
  }

  /* Return (gcd, x, y) of a and b such that ax + by = gcd */
  public static Triplet<Long, Long, Long> extendedEuclid(Long a, Long b) {
    Long x = 1L, y = 0L;
    Long x1 = 0L, y1 = 1L, a1 = a, b1 = b;
    while (b1 != 0L) {
      Long q = a1 / b1;
      
      Long c = x; // auxilary variable
      x = x1;
      x1 = c - q * x1;
  
      c = y;
      y = y1;
      y1 = c - q * y1;
  
      c = a1;
      a1 = b1;
      b1 = c - q * b1;
    }
    return new MathUtil.Triplet<Long,Long,Long>(a1, x, y);
  }

  public static Pair<Long, Long> solveEquation(Long a, Long b, Long c) {
    if (!(a != 0L  || b != 0L)) return null;
    Triplet<Long, Long, Long> t = extendedEuclid(Math.abs(a), Math.abs(b));
    Long g = t.x;
    if (c % g != 0) return null;
    Long x0 = (Long)t.y, y0 = (Long)t.z;
 
    x0 *= ((a > 0) ? c / g : -c / g);
    y0 *= ((b > 0) ? c / g : -c / g);
  
    return new Pair<Long, Long>(x0, y0); 
  }
}
