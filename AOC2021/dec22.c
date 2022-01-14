//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>
#include <assert.h>

#define NCUBOIDSMAX 100000

int min (int a, int b) {return a < b ? a : b; };
int max (int a, int b) {return a < b ? b : a; };

void add_intersection (int *ncs, int (*cs)[7], int c0[7], int c1[7])
{
  int c[7] = {0};
  c[0] = -c0[0];
  c[1] = max(c0[1], c1[1]);
  c[2] = min(c0[2], c1[2]);
  c[3] = max(c0[3], c1[3]);
  c[4] = min(c0[4], c1[4]);
  c[5] = max(c0[5], c1[5]);
  c[6] = min(c0[6], c1[6]);
  if (c[1] <= c[2] && c[3] <= c[4] && c[5] <= c[6]) {
    if (*ncs > NCUBOIDSMAX - 2) exit(11);
    //printf("In add before realloc: cs *ncs sizeof(c) sizeof(*cs) %p %d %lu %lu\n", cs, *ncs, sizeof c, sizeof (*cs));
    //cs = realloc(cs, (*ncs + 1) * sizeof c);
    //printf("In add after realloc: cs *ncs sizeof(c) sizeof(*cs) %p %d %lu %lu\n", cs, *ncs, sizeof c, sizeof (*cs));
    memcpy(cs[*ncs], c, sizeof c);
    (*ncs)++;
  }
}

uint64_t count_lit(int ncs, int cs[ncs][7])
{
  uint64_t n = 0;
  for (int i = 0; i < ncs; i++) {
    uint64_t c[7];
    for (int j = 0; j < 7; j++)
      c[j] = (uint64_t) cs[i][j];
    n += c[0] * (c[2] - c[1] + 1) * (c[4] - c[3] + 1) * (c[6] - c[5] + 1);
  }
  return n;
}

int main(void)
{
  int (*cs)[7] = calloc(NCUBOIDSMAX, sizeof (*cs));
  int ncs = 0;
  for (;;) {
    char s[4] = {0};
    int c[7] = {0};
    int i = scanf("%3s x=%d..%d,y=%d..%d,z=%d..%d\n",
                  s, &c[1], &c[2], &c[3], &c[4], &c[5], &c[6]);
    c[0] = s[1] == 'n' ? 1 : -1;
    //if (abs(c[1]) > 50) break;
    if (i != 7) break;
    for (int i = 0, ncc = ncs; i < ncc; i++) {
      add_intersection(&ncs, cs, cs[i], c);
    }
    if (c[0] > 0) {
      if (ncs > NCUBOIDSMAX - 2) exit(11);
      memcpy(cs[ncs], c, sizeof c);
      ncs++;
    }
  }
  printf("%llu\n", count_lit(ncs, cs));
}
