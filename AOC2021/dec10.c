//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFLEN 1024
#define SCORELEN 1024

int map1[128] =
  {
    ['('] = 3, ['['] = 57, ['{'] = 1197, ['<'] = 25137,
    [')'] = -3, [']'] = -57, ['}'] = -1197, ['>'] = -25137
  };

int map2[128] =
  {
    ['('] = 1, ['['] = 2, ['{'] = 3, ['<'] = 4,
    [')'] = -1, [']'] = -2, ['}'] = -3, ['>'] = -4
  };

int cmpfunc (const void * a, const void * b) {
  if ( *(long long*)a < *(long long*)b) return(-1);
  if ( *(long long*)a > *(long long*)b) return(1);
  return(0);
}

struct Scores
{
  int s1;
  long long s2;
};

struct Scores score(void)
{
  struct Scores scores = {0};
  int i = 0;
  char s[BUFLEN] = {0};
  long long ss[SCORELEN] = {0};
  int is = 0;
  while ((s[++i] = getchar()) != EOF)
    {
      if (s[i] == '\n')
        {
          for (ss[is] = 0, i-- ;i > 0 ; i--)
            ss[is] = 5 * ss[is] + map2[s[i]];
          is++;
          continue;
        }
      if (map2[s[i]] < 0)
        {
          if ((map2[s[i]] + map2[s[i-1]]) == 0)
            {
              i -= 2;
            }
          else
            {
              scores.s1 -= map1[s[i]];
              i = 0;
              char c; while((c = getchar()) != EOF) {if (c == '\n') break;}
            }
        }
      if (i >= BUFLEN - 1) exit(1);
    }
  qsort(ss, is, sizeof(ss[0]), cmpfunc);
  scores.s2 = ss[is/2];
  return(scores);
}

int main(int argc, char *argv[])
{
  struct Scores s = score();
  printf("%d\n", s.s1);
  printf("%lld\n", s.s2);
  return(0);
}
