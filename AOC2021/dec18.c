//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>

#define AMAX 64
#define LMAX 100
#define LINES 100

struct Number {int a[AMAX]; };
typedef struct Number Number;

void scan_number(Number *n, char *s)
{
  for (int j = 0; j < AMAX; j++) n->a[j] = -1;
  int i = 0;
  for (int j = 0; j < (int) strnlen(s, LMAX) - 1 ; j++)
    {
      if (j >= LMAX) exit(1);
      switch (s[j])
        {
        case '\n':
        case '\0':
          goto done;
        case '[':
          i = 2*i + 1;
          break;
        case ']':
          i = (i - 1) / 2;
          break;
        case ',':
          i = 2 * ((i - 1) / 2) + 2;
          break;
        default:
          n->a[i] = s[j] - '0';
        }
    }
 done:
  return;
}

void pn(Number *n, int i)
{
  if (n->a[i] < 0)
    {
      putchar('[');
      pn(n, 2*i + 1);
      putchar(',');
      pn(n, 2*i + 2);
      putchar(']');
    }
  else
    {
      printf("%d", n->a[i]);
    }
}

void print_number(Number n)
{
  pn(&n, 0);
  putchar('\n');
}

void dfs_order (Number *n, int i, int idx[AMAX], int *nis)
{
  if (n->a[i] < 0)
    {
      dfs_order(n, 2*i + 1, idx, nis);
      dfs_order(n, 2*i + 2, idx, nis);
    }
  else
    {
      idx[(*nis)++] = i;
    }
}

int explode (Number *n)
{
  int idx[AMAX] = {0};
  int nis = 0;
  int i;
  dfs_order(n, 0, idx, &nis);
  for (i = 0; i < nis; i++)
    if (idx[i] > 30)
      break;
  if (i < nis)
    {
      if (i > 0)
        n->a[idx[i-1]] += n->a[idx[i]];
      if (i < nis - 2)
        n->a[idx[i+2]] += n->a[idx[i+1]];
      n->a[idx[i]] = -1;
      n->a[idx[i+1]] = -1;
      n->a[(idx[i] - 1) / 2] = 0;
      explode(n);
      return 1;
    }
  else
    return 0;
}

int split (Number *n)
{
  int idx[AMAX] = {0};
  int nis = 0;
  int i;
  dfs_order(n, 0, idx, &nis);
  for (i = 0; i < nis; i++)
    if (n->a[idx[i]] > 9)
      {
        n->a[2*idx[i] + 1] = n->a[idx[i]] / 2;
        n->a[2*idx[i] + 2] = n->a[idx[i]] - n->a[idx[i]] / 2;
        n->a[idx[i]] = -1;
        return 1;
        break;
      }
  return 0;
}

void reduce_number(Number *n)
{
  while (explode (n) || split (n));
}

void add_numbers(Number *n0, Number *n1)
{
  if (n0->a[0] == 0)
    {
      for (int j = 0; j < AMAX; j++)
        n0->a[j] = n1->a[j];
      return;
    }

  int a[AMAX];
  for (int j = 0; j < AMAX; j++) a[j] = -1;

  int k = 1, m = 1, l = 0, r = 0;
  for (int j = 0; j < 5; j++)
    {
      for (int i = 0; i < k; i++)
        a[m++] = n0->a[l++];
      for (int i = 0; i < k; i++)
        a[m++] = n1->a[r++];
      k *= 2;
    }
  for (int j = 0; j < AMAX; j++) n0->a[j] = a[j];
  reduce_number (n0);
}

int magnitude (Number *n, int i)
{
  if (n->a[i] >= 0)
    return n->a[i];
  return 3*magnitude (n, 2 * i + 1) + 2*magnitude (n, 2 * i + 2);
}

int main(int argc, char *argv[])
{
  Number n[LINES] = {0}, m = {0};
  ssize_t read;
  char *line = 0;
  size_t len = 0;
  int c = 0;
  while ((read = getline(&line, &len, stdin)) != -1) {
    scan_number (&n[c++], line);
    add_numbers(&m, &n[c-1]);
  }
  free(line);
  printf("%d\n", magnitude(&m, 0));
  int s = 0, ss;
  for (int i = 0; i < c; i++)
    {
      for (int j = 0; j < c; j++)
        if ( i != j)
          {
            for (int k = 0; k < AMAX; k++)
              m.a[k] = n[i].a[k];
            add_numbers(&m, &n[j]);
            ss = magnitude(&m, 0);
            if (ss > s) s = ss;
          }
    }
  printf("%d\n", s);
  return 0;
}
