with Interfaces.C; use Interfaces.C;
with mylib;

package body c_functions is
  function c_factorial(i: int) return int is
  begin
    return int(mylib.Factorial(Integer(i)));
  end c_factorial;

  function c_gcd(a: int; b: int) return int is
  begin
    return int(mylib.GCD(Integer(a), Integer(b)));
  end c_gcd;

  function c_solve_equation(a: int; b: int; c: int) return c_sollution_ptr is
    res: mylib.Pair;
    c_res: c_sollution_ptr;
  begin
    res := mylib.Solve(Integer(a), Integer(b), Integer(c));
    if (res.isGoodSolution) then
      c_res := new c_sollution'(int(1), int(res.x), int(res.y));
    else
      c_res := new c_sollution'(int(0), int(0), int(0));
    end if;
    return c_res;
  end c_solve_equation;
end c_functions;