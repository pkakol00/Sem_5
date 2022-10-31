with Ada.Text_IO;

package body mylib is

-- Recursive implementation
function Factorial (n: Integer) return Integer is
  x: Integer := n;
  ack: Integer := 1;
begin
  if (n <= 1) then
    return 1;
  else
    while (x /= 1) loop 
      ack := ack * x;
      x := x - 1;
    end loop;
    return ack;
  end if;
end Factorial;

function GCD(a: Integer; b: Integer) return Integer is
  x : Integer := a;
  y : Integer := b;
  c : Integer;
begin
  while(y /= 0) loop
    c := x;
    x := y;
    y := c mod y;
  end loop;
  return x;
end GCD;

function ExtEuclidian(
  a : Integer;
  b : Integer;
  x : in out Integer;
  y : in out Integer
) return Integer is 
  x1 : Integer := 0;
  y1 : Integer := 1;
  a1: Integer := a;
  b1: Integer := b;
  q : Integer;
  c : Integer;
begin
  x := 1;
  y := 0;
  while (b1 /= 0) loop
    q := a1 / b1;
    
    c := x;
    x := x1;
    x1 := c - q * x1;

    c := y;
    y := y1;
    y1 := c - q * y1;

    c := a1;
    a1 := b1;
    b1 := c - q * b1;
  end loop;
  return a1;
end ExtEuclidian;

function Solve(a: Integer; b: Integer; c: Integer) return Pair is
  x0 : Integer;
  y0 : Integer;
  g : Integer;
begin
  if (a = 0 and b = 0) then
    return (False, 0, 0);
  end if;
  g := ExtEuclidian(abs a, abs b, x0, y0);
  if (c mod g /= 0) then
    return (False, 0, 0);
  end if;

  if (a > 0) then
    x0 := x0 * c / g;
  else
    x0 := -(x0 * c / g);
  end if;
  if (b > 0) then
    y0 := y0 * c / g;
  else
    y0 := -(y0 * c / g);
  end if;
  return (True, x0, y0);
end Solve;

procedure Version is
begin
  Ada.Text_IO.Put_Line("Version Iterative");
end Version;

end mylib;