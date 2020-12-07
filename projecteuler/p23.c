//usr/bin/env cc "$0" -g -lm && exec ./a.out "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <math.h>
#include <stdbool.h>

#define NMAX 28123
#define SQRT_NMAX 168

int isAbundant(int n) {
  int pd[SQRT_NMAX];    // Proper divisors of n
  int npd = 0;          // Number of proper divisors
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) pd[npd++] = i;
  }

  int sum = 1;          // Sum of proper divisors (1 is always)
  // If i is a proper divisor of n, then i/n is, too.
  for (int i = 0; i < npd; i++)
    sum += pd[i] + n/pd[i];
  // Removing possible double counting above
  if (pd[npd-1] * pd[npd-1] == n)
    sum -= pd[npd-1];
  return (sum > n);
}


int main(int argc, char *argv[]) {
  int a[NMAX] = {0};     // Abundant numbers
  int na = 0;            // Number of abundant numbers
  for (int i = 1; i < NMAX; i++) {
    if (isAbundant(i)) a[na++] = i;
  }

  int tmp[NMAX] = {0};   // Element tmp[i] tells if i+1 is a sum of
                         // two abundant numbers
  for (int i = 0; i < na; i++) {
    for (int j = 0; j < na; j++) {
      int n = a[i] + a[j];
      if ( n <= NMAX) tmp[n - 1] = 1;
    }
  }

  // Sum of all numbers that are not a sum of two abundant numbers
  int sum = 0;
  for (int i = 0; i < NMAX; i++) {
    if (!tmp[i]) sum += i + 1;
  }
  printf("%d\n", sum);
}
