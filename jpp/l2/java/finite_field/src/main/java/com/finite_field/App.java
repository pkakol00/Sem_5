package com.finite_field;

public class App 
{
    public static void main( String[] args )
    {
      try {
        System.out.println(FiniteField.pow(new FiniteField(21L), new FiniteField(0L)));
        System.out.println(FiniteField.div(new FiniteField(1L), new FiniteField(3L)));
        
      } catch (Exception e) {
        System.out.println(e);
      }
    }
}
