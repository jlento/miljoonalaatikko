//usr/bin/env cc "$0" && exec ./a.out < dec03.txt

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

#define LEN 12

int main(int argc, char *argv[]) {

  int64_t a[LEN] = {0};
  int c, i = 0;
  while((c = getc(stdin)) != EOF) {
    switch(c) {
    case '0':
      a[i++]--;
      break;
    case '1':
      a[i++]++;
    }
    i %= LEN;
  }
  char g[LEN+1] = {0}, e[LEN+1] = {0};
  for (i = 0; i < LEN; i++)
    if (a[i] < 0) {
      g[i] = '0';
      e[i] = '1';
    } else if (a[i] > 0) {
      g[i] = '1';
      e[i] = '0';
    } else {
      return(1);
    }
  printf("%lld\n", strtoull(g, 0, 2) * strtoull(e, 0 , 2));
  return(0);
}
