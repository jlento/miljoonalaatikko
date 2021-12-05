//usr/bin/env cc "$0" && exec ./a.out < dec01.txt

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

int main(int argc, char *argv[]) {

  int64_t current, previous = 0, counter = -1;
  while (scanf("%" SCNd64, &current) != EOF) {
    if (current > previous) counter++;
    previous = current;
  }
  printf("%" PRId64 "\n", counter);
  return(0);
}
