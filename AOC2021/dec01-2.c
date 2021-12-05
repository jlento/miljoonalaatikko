//usr/bin/env cc "$0" && exec ./a.out < dec01.txt

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

#define MAXLEN 1024

int main(int argc, char *argv[]) {

  int64_t s = 0, r0 = 0, r1 = 0, r2 = 0, counter = -3;
  while (scanf("%" SCNd64, &r2) != EOF) {
    if(r0 + r1 + r2 > s) counter++;
    s = r0 +r1 + r2;
    r0 = r1; r1 =r2;
  }
  printf("%" PRId64 "\n", counter);
  return(0);
}
