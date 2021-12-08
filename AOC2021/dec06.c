//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#define NSTAGES 9
void init(uint64_t fish[NSTAGES])
{
  int d;
  while (scanf("%d", &d) != EOF)
    {
      fish[d]++;
      scanf(",");
    }
}

void waitn(uint64_t fish[NSTAGES], int n)
{
  for (int t = 0; t < n; t++)
    {
      uint64_t z = fish[0];
      for (int i = 0; i < 8; i++)
        fish[i] = fish[i + 1];
      fish[6] += z;
      fish[8] = z;
    }
}

void count(uint64_t fish[NSTAGES])
{
  uint64_t c = 0;
  for (int i = 0; i < NSTAGES; i++)
    c += fish[i];
  printf("%llu\n", c);
}

int main(int argc, char *argv[])
{
  uint64_t fish[NSTAGES] = {0};
  init(fish);
  waitn(fish, 80);
  count(fish);
  waitn(fish, 256 - 80);
  count(fish);
  return(0);
}
