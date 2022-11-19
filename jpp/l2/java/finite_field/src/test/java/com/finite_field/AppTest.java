package com.finite_field;

// import static org.junit.Assert.*;
// 
// import org.junit.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class AppTest 
{
  @Test
  public void TestCompare() {
    FiniteField a = new FiniteField(2L), b = new FiniteField(3L);
    
    assertEquals(a.compareTo(b), -1);
    assertEquals(b.compareTo(b), 0);
    assertEquals(b.compareTo(a), 1);
    
    assertEquals(a, a);
    assertNotEquals(a, b);

    assertEquals(new FiniteField(-1L), new FiniteField(-1L));
  }

  @Test
  public void TestAdd() {
    FiniteField a = new FiniteField(2L), b = new FiniteField(3L);
    FiniteField c = new FiniteField(-1L);

    assertEquals(FiniteField.add(a, c), new FiniteField(1L));

    assertEquals(FiniteField.sbstr(a, b), c);
  }

  @Test
  public void TestMlt() {
    FiniteField a = new FiniteField(3L), b = new FiniteField(0L);

    assertEquals(FiniteField.mlt(a, new FiniteField(5L)), new FiniteField(15L));
    try {
      assertEquals(FiniteField.div(new FiniteField(1L), a), new FiniteField(823045261L));
    } catch(Exception e) {}
    assertThrows(Exception.class, () -> {FiniteField.div(a, b);});
  }

  @Test 
  public void TestPow() {
    FiniteField a = new FiniteField(2L);
    assertEquals(FiniteField.pow(a, new FiniteField(5L)), new FiniteField(32L));
    assertEquals(FiniteField.pow(a, new FiniteField(0L)), new FiniteField(1L));
  }
}
