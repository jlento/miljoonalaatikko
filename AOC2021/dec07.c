//usr/bin/env cc -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#define NCRABS 1000
#define MIN(a,b) (((a)<(b))?(a):(b))

void init(int pos[NCRABS])
{
  int d;
  for (int i = 0; i < NCRABS; i++)
    {
      scanf("%d", &d);
      pos[i] = d;
      scanf(",");
    }
}

int consumption1(int pos[NCRABS], int to)
{
  int s = 0;
  for (int i = 0; i < NCRABS; i++)
    s += abs(pos[i] - to);
  return(s);
}

int consumption2(int pos[NCRABS], int to)
{
  int s = 0;
  for (int i = 0; i < NCRABS; i++)
    {
      int d = abs(pos[i] - to);
      s += (d * (d + 1)) / 2; 
    }
  return(s);
}

int cmpfunc (const void * a, const void * b) {
  return ( *(int*)a - *(int*)b );
}

int average(int pos[NCRABS])
{
  int s = 0;
  for (int i = 0; i < NCRABS; i++)
    {
      s += pos[i];
    }
  return(s / NCRABS);
}

int main(int argc, char *argv[])
{
  int pos[NCRABS];
  init(pos);
  qsort(pos, NCRABS, sizeof(int), cmpfunc);
  int c1 = consumption1(pos, pos[NCRABS/2]);
  int c2 = consumption1(pos, pos[NCRABS/2 + 1]);
  printf("%d\n", MIN(c1,c2));
  c1 = consumption2(pos, average(pos));
  c2 = consumption2(pos, average(pos) + 1);
  printf("%d\n", MIN(c1,c2));

  return(0);
}
