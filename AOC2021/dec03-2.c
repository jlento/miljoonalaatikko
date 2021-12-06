//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < dec03.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

#define LEN 12
#define LINES 1000

typedef int (*take_ft)(uint16_t, uint16_t);

int take1(uint16_t e, uint16_t p) {
  return(e & (1 << p));
}

int take0(uint16_t e, uint16_t p) {
  return(!(e & (1 << p)));
}

size_t nset(size_t n, uint16_t a[n], uint16_t p) {
  size_t c = 0;
  for (size_t i = 0; i < n; i++)
    if (take1(a[i], p)) c++;
  return(c);
}

uint16_t f(size_t n, uint16_t a[LINES], uint16_t p, take_ft f1, take_ft f2) {
  if (n == 1 ) return(a[0]);
  if (p < 0) exit(1);
  size_t na = 0;
  if (2 * nset(n, a, p) >= n) {
    for (size_t i = 0; i < n; i++)
      if (f1(a[i], p)) a[na++] = a[i];
  } else {
    for (size_t i = 0; i < n; i++)
      if (f2(a[i], p)) a[na++] = a[i];
  }
  return(f(na, a, p - 1, f1, f2));
}

int main(int argc, char *argv[]) {

  uint16_t o2[LINES] = {0}, co2[LINES] = {0};

  char line[LEN + 2];
  for (size_t i = 0; i < LINES; i++) {
    fgets(line, LEN + 2, stdin);
    co2[i] = o2[i] = (uint16_t) strtol(line, 0, 2);
  }

  printf("%d\n",
         f(LINES,  o2, LEN - 1, take1, take0) *
         f(LINES, co2, LEN - 1, take0, take1));

  return(0);
}
