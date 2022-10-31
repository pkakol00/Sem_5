with Interfaces.C; use Interfaces.C;

package c_functions is
  function c_factorial(i: int) return int
    with  
      Convention => C,
      Export => True,
      External_Name => "ada_factorial";

  function c_gcd(a: int; b: int) return int 
    with
      Convention => C,
      Export => True,
      External_Name => "ada_gcd";

  type c_sollution is record
    correct: int;
    x: int;
    y: int;
  end record;
  type c_sollution_ptr is access all c_sollution;

  function c_solve_equation(a: int; b: int; c: int) return c_sollution_ptr
    with
      Convention => C,
      Export => True,
      External_Name => "ada_solve_equation";
end c_functions;