//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>

int part1(int ya)
{
  return (abs(ya) * (abs(ya) - 1)) / 2;
}




int part2(int xa, int xb, int ya, int yb)
{
  int c = 0;
  for (int y0 = ya; y0 <= part1(ya); y0++)
    {
      for (int x0 = (int) sqrt (2*xa); x0 <= xb; x0++)
        {
          int x = x0, y = y0;
          int i = 0, j = 0;
          while ((i <= xb) && (j >= ya))
            {
              if ((i >= xa) && (j <= yb))
                {
                  c++;
                  break;
                }
              i += x;
              j += y;
              x -= (x > 0) - (x < 0);
              y--;
            }
        }
    }
  return c;
}

int main(int argc, char *argv[])
{
  //printf("%d\n", part1(-10));
  printf("%d\n", part1(-136));
  //printf("%d\n", part2(20, 30, -10, -5));
  printf("%d\n", part2(150, 193, -136, -86));
}
