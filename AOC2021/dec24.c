//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <limits.h>
#include <math.h>
#include <assert.h>

#define LEN 14
#define MMAX 99999999999999

int b[LEN], c[LEN], d[LEN];
long bb[LEN];

void read_input(int b[LEN], int c[LEN], int d[LEN])
{
  for (int i = LEN - 1; i >= 0; i--)
    for (int j = 0; j < 18; j++)
      switch (j)
        {
        case 4:
          scanf("div z %d\n", &b[i]);
          break;
        case 5:
          scanf("add x %d\n", &c[i]);
          break;
        case 15:
          scanf("add y %d\n", &d[i]);
          break;
        default:
          scanf("%*[^\n]\n");
        }
}

void print_input(int b[LEN], int c[LEN], int d[LEN])
{
  for (int i = LEN - 1; i >= 0; i--)
    printf("%4d %4d %4d\n", b[i], c[i], d[i]);
}

long zfun(long z0, int a, int b, int c, int d)
{
  long x = z0;
  x %= 26;
  long z = z0 / b;
  x += c;
  x = (x == a);
  x = (x == 0);
  long y = 25;
  y *= x;
  y++;
  z *= y;
  y = a + d;
  y *= x;
  z += y;
  return z;
}


int nth(long a, int n)
{
  return ((a / (long) (pow(10, n) + 0.5)) % 10);
}

void decr(long *a, int n)
{
  *a -= (long) pow(10, n);
}

long solve1(int t, long z0, long m)
{
  if (t < 0) return 0;
  if (z0 > bb[t]) return 0;
  m *= 10;
  for (int a = 9; a > 0; a--)
    {
      long z = zfun (z0, a, b[t], c[t], d[t]);
      if (t == 0 && z == 0) return m + a;
      long mm = solve1 (t - 1, z, m + a);
      if (mm)
        return mm;
    }
  return 0;
}

long solve2(int t, long z0, long m)
{
  if (t < 0) return 0;
  if (z0 > bb[t]) return 0;
  m *= 10;
  for (int a = 1; a < 10; a++)
    {
      long z = zfun (z0, a, b[t], c[t], d[t]);
      if (t == 0 && z == 0) return m + a;
      long mm = solve2 (t - 1, z, m + a);
      if (mm)
        return mm;
    }
  return 0;
}

int main(void)
{
  assert(MMAX < LONG_MAX);
  read_input(b, c, d);
  //print_input(b, c, d);
  long s = 1;
  for (int i = 0; i < LEN; i++)
      bb[i] = (s *= b[i]);
  printf("%ld\n", solve1(13, 0, 0));
  printf("%ld\n", solve2(13, 0, 0));
}
