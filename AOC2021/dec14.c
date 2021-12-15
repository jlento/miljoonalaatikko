//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFMAX 32
#define BUFMAXFMT "31"

// Test case
//#define NCHAR 4
//const int charmap[256] = {['B'] = 0, ['C'] = 1, ['H'] = 2, ['N'] = 3};

#define NCHAR 10
const int charmap[256] = {
  ['B'] = 0, ['C'] = 1, ['F'] = 2, ['H'] = 3, ['K'] = 4,
  ['N'] = 5, ['O'] = 6, ['P'] = 7, ['S'] = 8, ['V'] = 9
};

long long hist[NCHAR] = {0};
long long pairhist[NCHAR*NCHAR] = {0};
int pairmap[NCHAR*NCHAR] = {0};

void init()
{
  char a, b, c, s[BUFMAX] = {0};
  scanf("%" BUFMAXFMT "s\n", s);
  while(scanf("%c%c -> %c\n", &a, &b, &c) != EOF)
    {
      pairmap[charmap[a] + NCHAR*charmap[b]] = charmap[c];
    }
  for (int i = 1; i < strlen(s); i++)
    pairhist[charmap[s[i-1]] + NCHAR*charmap[s[i]]]++;
  for (int i = 0; i < strlen(s); i++)
    hist[charmap[s[i]]]++;
}

void step()
{
  int m;
  long long n;
  long long tmp[NCHAR*NCHAR];
  for (int j = 0; j < NCHAR*NCHAR; j++)
    tmp[j] = 0;
  for (int j = 0; j < NCHAR; j++)
    for (int i = 0; i < NCHAR; i++)
    {
      if((n = pairhist[i + NCHAR*j]))
        {
          m = pairmap[i + NCHAR*j];
          tmp[i + NCHAR*m] += n;
          tmp[m + NCHAR*j] += n;
          hist[m] += n;
        }
    }
  for (int j = 0; j < NCHAR*NCHAR; j++)
    pairhist[j] = tmp[j];
}

void printhist()
{
  for (int i = 0; i < NCHAR; i++)
    printf("%2d %20lld\n", i, hist[i]);
  putchar('\n');
}

int main(int argc, char *argv[])
{
  init();
  for (int i = 0; i < 10; i++)
    step();
  printhist();
  for (int i = 0; i < 30; i++)
    step();
  printhist();
}
