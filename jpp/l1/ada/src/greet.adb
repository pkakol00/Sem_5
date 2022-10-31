with Ada.Text_IO;
with mylib; use mylib;

procedure Greet is
  p : Pair;
begin
   --  Print "Hello, World!" to the screen
   -- Ada.Text_IO.Put_Line (Integer'Image(GCD(9, 116)));
  -- d := ExtEuclidian(12, 14, x, y);
  
  Ada.Text_IO.Put_Line(Integer'Image(Factorial(5)));
  Ada.Text_IO.Put_Line("GCD:");
  Ada.Text_IO.Put_Line(Integer'Image(GCD(12,21)));
  Ada.Text_IO.Put_Line("ExtEuclid:");

  p := Solve(12, 7, 34);
  Ada.Text_IO.Put_Line(Integer'Image(p.x));
  Ada.Text_IO.Put_Line(Integer'Image(p.y));
  Ada.Text_IO.Put_Line(Integer'Image(p.x * 12 + p.y * 7));

  Version;
  
end Greet;
