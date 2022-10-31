with Ada.Text_IO;

package body mylib is

-- Recursive implementation
function Factorial (n: Integer) return Integer is
begin
  if (n > 0) then
    return n * Factorial(n - 1);
  else
    return 1;
  end if;
end Factorial;

function GCD(a: Integer; b: Integer) return Integer is
begin
  if (b = 0) then
    return a;
  else 
    return GCD(b, a mod b);
  end if;
end GCD;

function ExtEuclidian(
  a : Integer;
  b : Integer;
  x : in out Integer;
  y : in out Integer
) return Integer is 
  x1 : Integer;
  y1 : Integer;
  d : Integer;
begin
  if (b = 0) then
    x := 1;
    y := 0;
    return a;
  else 
    d := ExtEuclidian(b, a mod b, x1, y1);
    x := y1;
    y := x1 - y1 * (a / b);
    return d;
  end if;
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
  Ada.Text_IO.Put_Line("Version Recursive");
end Version;

end mylib;