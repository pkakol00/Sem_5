package mylib is
  function Factorial (n: Integer) return Integer;

  function GCD(a: Integer; b: Integer) return Integer;

  type Pair is record
    isGoodSolution: Boolean;
    x : Integer;
    y : Integer;
  end record;

  function ExtEuclidian(
    a : Integer;
    b : Integer;
    x : in out Integer;
    y : in out Integer
  ) return Integer;

  function Solve(a: Integer; b: Integer; c: Integer) return Pair;

  procedure Version;
end mylib;

