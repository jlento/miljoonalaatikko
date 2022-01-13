//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>
#include <assert.h>

void game1()
{
  int s = 0;
  for (int p1 = 8 - 1, p2 = 5 - 1, s1 = 0, s2 = 0, d = 0;;) {
    s = 0;
    for (int i = 0; i < 3; i++)
      s += (d++) % 100 + 1;
    p1 = (p1 + s) % 10;
    s1 += p1 + 1;
    if (s1 > 999) {
      printf("%d\n", d * s2);
      break;
    }
    s = 0;
    for (int i = 0; i < 3; i++)
      s += (d++) % 100 + 1;
    p2 = (p2 + s) % 10;
    s2 += p2 + 1;
    if (s2 > 999) {
      printf("%d\n", d * s1);
      break;
    }
  }
}

static uint64_t cache[10][10][30][31][2] = {0};
static int nmoves[] = {0, 0, 0, 1, 3, 6, 7, 6, 3, 1};

void game2(uint64_t *wins1, uint64_t *wins2, int pos1, int pos2, int score1, int score2)
{
  //printf("%llu %llu %d %d %d %d\n", *wins1, *wins2, pos1, pos2, score1, score2);
  if (cache[pos1-1][pos2-1][score1][score2][0] || cache[pos1-1][pos2-1][score1][score2][1]) {
    *wins1 = cache[pos1-1][pos2-1][score1][score2][0];
    *wins2 = cache[pos1-1][pos2-1][score1][score2][1];
    return;
  }
  if (score2 > 20) {
    cache[pos1-1][pos2-1][score1][score2][0] = 0;
    cache[pos1-1][pos2-1][score1][score2][1] = 1;
    *wins1 = 0;
    *wins2 = 1;
    return;
  }
  *wins1 = 0; *wins2 = 0;
  for (int move = 3; move < 10; move++) {
    int pos1_;
    if (!(pos1_ = (pos1 + move) % 10)) pos1_ = 10;
    uint64_t w1 = 0, w2 = 0;
    game2 (&w2, &w1, pos2, pos1_, score2, score1 + pos1_);
    *wins1 += nmoves[move] * w1;
    *wins2 += nmoves[move] * w2;
    cache[pos1-1][pos2-1][score1][score2][0] = *wins1;
    cache[pos1-1][pos2-1][score1][score2][1] = *wins2;
   }
}

int main(void)
{
  game1();
  uint64_t wins1 = 0, wins2 = 0;
  game2(&wins1, &wins2, 8, 5, 0, 0);
  printf("%llu %llu\n", wins1, wins2);
  return 0;
}
