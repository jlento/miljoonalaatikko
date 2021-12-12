//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENX 10
#define LENY 10
#define HALOVALUE ' '
#define NSTEPS 100

char g[(LENX+2)*(LENY+2)];

#define START (LENX+3)
#define STOP ((LENX+2)*(LENY+1)-1)
int next(int p)  {return((p + 2) % (LENX+2) ? p + 1 : p + 3);};
int up(int p)    {return(p - (LENX+2));};
int down(int p)  {return(p + (LENX+2));};
int left(int p)  {return(p - 1);};
int right(int p) {return(p + 1);};
int upl(int p)    {return(p - (LENX+2) - 1);};
int upr(int p)  {return(p - (LENX+2) + 1);};
int downl(int p)    {return(p + (LENX+2) - 1);};
int downr(int p)  {return(p + (LENX+2) + 1);};

void init(void)
{
  memset(g, HALOVALUE, sizeof(g));
  for (int j = 0, p = START; j < LENY; j++)
    {
      for (int i = 0; i < LENX; i++, p = next(p))
        g[p] = getchar();
      getchar();
    }
}

void printstep(int s)
{
  printf("Step %d\n", s);
  for (int j = 0, p = 0; j < LENY+2; j++)
    {
      for (int i = 0; i < LENX+2; i++, p++)
        putchar(g[p]);
      putchar('\n');
    }
}

void sethalo()
{
  for (int i = 0; i < LENX+2; i++)
    g[i] = HALOVALUE;
  for (int i = (LENX+2)*(LENY+1); i < (LENX+2)*(LENY+2); i++)
    g[i] = HALOVALUE;
  for (int i = 0; i < (LENX+2)*(LENY+1); i += (LENX+2))
    g[i] = HALOVALUE;
  for (int i = LENX+1; i < (LENX+2)*(LENY+2); i += (LENX+2))
    g[i] = HALOVALUE;
}

int step()
{
  int c = 0, cc = 0;
  for (int i = 0; i < (LENX+2)*(LENY+2); i++)
    g[i]++;
  do
    {
      cc = 0;
      for (int i = START; i < STOP; i = next(i))
        {
          if (g[i] > '9')
            {
              cc++;
              g[upl(i)]++;   g[up(i)]++;       g[upr(i)]++;
              g[left(i)]++;  g[i] = HALOVALUE; g[right(i)]++;
              g[downl(i)]++; g[down(i)]++;     g[downr(i)]++;
            }
        }
      c += cc;
    } while (cc);
  for (int i = 0; i < (LENX+2)*(LENY+2); i++)
    if (g[i] < '0') g[i] = '0';
  sethalo();
  return(c);
}

int main(int argc, char *argv[])
{
  init();
  //printstep(0);
  int s = 0, n = 0;
  for (int i = 1; n != 100; i++)
    {
      n = step();
      s += n;
      //printstep(i);
      if (i == 100) printf("%d\n", s);
      if (n == 100) printf("%d\n", i);
    }
  return(0);
}
