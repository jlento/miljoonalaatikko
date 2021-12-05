//usr/bin/env cc "$0" && exec ./a.out < dec02.txt

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>

#define MAXLEN 1024

int main(int argc, char *argv[]) {

  int64_t n, f = 0, d = 0, a = 0;
  char line[MAXLEN];
  char *token;
  while (fgets(line, MAXLEN, stdin)) {
    token = strtok(line, " ");
    sscanf(strtok(0, " "), "%" SCNd64, &n);
    switch (*token) {
    case 'f':
      f += n;
      d += a * n;
      break;
    case 'u':
      a -= n;
      break;
    case 'd':
      a += n;
      break;
    }
  }
  printf("%" PRId64 "\n", f * d);
  return(0);
}
