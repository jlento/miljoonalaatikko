//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define NSEGS 7
#define SCANSEG "%7s"
#define NPATS 10
#define NOUTS 4
#define NDISPS 200

int popcount(char c)
{
  int n = 0;
  while (c)
    {
      n += 1 & c;
      c >>= 1;
    }
  return(n);
}

char seg2bits(char s[NSEGS + 1])
{
  char c = 0;
  for (int i = 0; i < NSEGS + 1; i++ )
    {
      if (!s[i]) break;
      c |= 1 << (s[i] - 'a');
    }
  return(c);
}

void init(char patterns[NDISPS][NPATS], char outs[NDISPS][NOUTS])
{
  for (int i = 0; i < NDISPS; i++)
    {
      for (int j = 0; j < NPATS; j++)
        {
          char s[NSEGS + 1] = {0};
          scanf(SCANSEG, s);
          patterns[i][j] = seg2bits(s);
        }
      scanf(" | ");
      for (int j = 0; j < NOUTS; j++)
        {
          char s[NSEGS + 1] = {0};
          scanf(SCANSEG, s);
          outs[i][j] = seg2bits(s);
        }
    }
}

int count1478(char outs[NDISPS][NOUTS])
{
  int s = 0;
  for (int i = 0; i < NDISPS; i++)
    for (int j = 0; j < NOUTS; j++)
      {
        int l = popcount(outs[i][j]);
        if(l == 2 || l == 3 || l == 4 || l == 7)
          s++;
      }
  return(s);
}

int dispsum(char pats[NPATS], char outs[NOUTS])
{
  char d[NPATS] = {0};
  for (int i = 0; i < NPATS; i++)
    {
      if (popcount(pats[i]) == 2) d[1] = pats[i];
      if (popcount(pats[i]) == 3) d[7] = pats[i];
      if (popcount(pats[i]) == 4) d[4] = pats[i];
      if (popcount(pats[i]) == 7) d[8] = pats[i];
    }
  for (int i = 0; i < NPATS; i++)
    {
      if (pats[i] == d[1] ||pats[i] == d[4] || pats[i] == d[7]
          || pats[i] == d[8]) continue;
      if (popcount(pats[i] ^ d[7]) == 2) d[3] = pats[i];
      if (popcount(pats[i] ^ d[7]) == 5) d[6] = pats[i];
    }
  d[0] = ((d[8] - d[1]) ^ d[4]) | (d[8] - d[3]);
  d[2] = (d[4] ^ d[6]) | (d[8] - d[0]);
  d[5] = d[6] - (d[8] - (d[3] | d[4]));
  d[9] = d[8] - (d[8] - (d[3] | d[4]));

  int dm[256] = {0};
  for (int i = 0; i < NPATS; i++)
    dm[d[i]] = i;

  int s = 0;
  for (int i = 0; i < NOUTS; i++)
      s += dm[outs[i]] * pow(10,NOUTS - i - 1);
  return(s);
}

int sum(char patterns[NDISPS][NPATS], char outs[NDISPS][NOUTS])
{
  int s = 0;
  for (int i = 0; i < NDISPS; i++)
      s += dispsum(patterns[i], outs[i]);
  return(s);
}

int main(int argc, char *argv[])
{
  char patterns[NDISPS][NPATS] = {0};
  char outs[NDISPS][NOUTS] = {0};
  init(patterns, outs);
  printf("%d\n", count1478(outs));
  printf("%d\n", sum(patterns, outs));
  return(0);
}
