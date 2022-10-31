#include <stdio.h>

#include <my_math.h>

int main(int argc, char** argv) {
  // 12 * 4 + 7 * -2 = 34
  int_pair* res = solve_equation(12, 7, 34);
  if (res) {
    printf("a: %d b: %d\n", res->x, res->y);
    printf("%d\n", res->x * 12 + res->y * 7);
    printf("%d\n", res->x * 12 + res->y * 7 == 34);
  } else {
    printf("no solutuion exists\n");
  }

  used_version();

  return 0;
}
