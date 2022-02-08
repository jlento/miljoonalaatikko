//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>
#include <strings.h>
#include <assert.h>

#define XLEN 139
#define YLEN 137
#define XFMT "%.139s\n"

typedef char (*Board)[XLEN];

void print_game(Board b)
{
  for (int i = 0; i < YLEN; i++)
    printf(XFMT, b[i]);
}

int main(void)
{
  Board b0 = malloc(XLEN * YLEN * sizeof (char) + 1);
  Board b1 = malloc(XLEN * YLEN * sizeof (char) + 1);
  for (int i = 0; i < YLEN; i++)
    scanf("%s\n", b0[i]);
  //print_game(b0);
  for (int c = 1;; c++) {
    int t = 0;
    memcpy(b1, b0, XLEN * YLEN * sizeof (char));
    for (int j = 0; j < YLEN; j++)
      for (int i = 0; i < XLEN; i++) {
        if (b1[j][i] != '>') continue;
        int ii = (i + 1) % XLEN;
        if (b1[j][ii] == '.') {
          b0[j][i] = '.';
          b0[j][ii] = '>';
          t = 1;
        }
      }
    memcpy(b1, b0, XLEN * YLEN * sizeof (char));
    for (int i = 0; i < XLEN; i++) {
      for (int j = 0; j < YLEN; j++) {
        if (b1[j][i] != 'v') continue;
        int jj = (j + 1) % YLEN;
        if (b1[jj][i] == '.') {
          b0[j][i] = '.';
          b0[jj][i] = 'v';
          t = 1;
        }
      }
    }
    if (t == 0) {
      printf("%d\n", c);
      //print_game(b0);
      break;
    }
  }
}
