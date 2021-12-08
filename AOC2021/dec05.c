//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>

#define BUF 1024
#define NLINES 500
#define LEN 1000
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

void read_lines(int ls[NLINES * 4])
{
  for (int i = 0; i < NLINES; i++)
    {
      scanf("%d,%d -> %d,%d\n", &ls[4*i], &ls[4*i+1], &ls[4*i+2], &ls[4*i+3]);
    }
}

int crossings(int a[LEN*LEN])
  {
    int r = 0;
    for (int i = 0; i < LEN*LEN; i++)
      if (a[i] > 1) r++;
    return(r);
  }

void hzlines(int ls[NLINES*4], int a[LEN*LEN])
{
  for (int k = 0; k < NLINES; k++)
    {
      int x1 = ls[4*k], y1 = ls[4*k+1], x2 = ls[4*k+2], y2 = ls[4*k+3];
      if (x1 == x2)
        {
          for (int i = x1, j = MIN(y1,y2); j < MAX(y1,y2) + 1; j++)
            a[i + j * LEN]++;
        }
      else if (y1 == y2)
        {
          for (int i = MIN(x1,x2), j = y1; i < MAX(x1,x2) + 1; i++)
            a[i + j * LEN]++;
        }
    }
}

void diaglines(int ls[NLINES*4], int a[LEN*LEN])
{
  for (int k = 0; k < NLINES; k++)
    {
      int x1 = ls[4*k], y1 = ls[4*k+1], x2 = ls[4*k+2], y2 = ls[4*k+3];
      if (!(x1 == x2) && !(y1 ==y2) && abs(x1-x2) == abs(y1-y2))
        {
          if (x1 < x2 && y1 < y2)
            {
              for (int i = x1, j = y1; i <= x2; i++, j++)
                a[i + j * LEN]++;
            }
          else if (x1 > x2 && y1 < y2)
            {
              for (int i = x1, j = y1; i >= x2; i--, j++)
                a[i + j * LEN]++;
            }
          else if (x1 < x2 && y1 > y2)
            {
              for (int i = x1, j = y1; i <= x2; i++, j--)
                a[i + j * LEN]++;
            }
          else if (x1 > x2 && y1 > y2)
            {
              for (int i = x1, j = y1; i >= x2; i--, j--)
                a[i + j * LEN]++;
            }

        }
    }
}


int main(int argc, char *argv[])
{
  int ls[NLINES * 4] = {0};
  int a[LEN * LEN] = {0};
  read_lines(ls);
  hzlines(ls, a);
  printf("%d\n", crossings(a));
  diaglines(ls, a);
  printf("%d\n", crossings(a));
  return(0);
}
