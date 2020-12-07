//usr/bin/env cc "$0" -lm && exec ./a.out "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <math.h>

int factorial(int n)
{
  int f = 1;
  while (n > 1) {
    f *= n--;
  }
  return f;
}

int shift(char *a, int j, int n) {
  for (int i = j; i < n - 1; i++ ) {
    a[i] = a[i + 1];
  }
  a[n-1] = 'X';
}

int main(int argc, char *argv[])
{
  char a[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  int n = 1000000;    // nth permutation
  if (argc > 1) sscanf(argv[1], "%d", &n);
  printf("%d  ", n);
  n--;
  for (int i = 0; i < 10; i++) {
    int f = factorial(9 - i);
    printf("%c", a[n/f]);
    shift(a, n/f, 10);
    n %= f;
  }
  printf("\n");
}
