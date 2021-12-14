//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NPMAX 2048
#define NFMAX 2048
#define WMAX  2048

void init(int *na, int a[NPMAX], int *nf, int f[NFMAX], char d[NFMAX])
{
  int n;
  *na = 0; *nf = 0;
  while(scanf("%d,%d\n", &a[*na], &a[*na + 1]))
    *na += 2;
  while((n = scanf("fold along %c=%d\n", &d[*nf], &f[*nf])) != EOF)
      (*nf)++;
  //for (int i = 0; i < *nf; i++)
  //  printf("fold along %c=%d\n", d[i], f[i]);
}

void printa(int na, int a[NPMAX])
{
  for (int i = 0; i < na; i += 2)
    printf("%d,%d\n", a[i], a[i + 1]);
}

int compar(const void *aa, const void *bb)
{
  int *a = (int*)aa;
  int *b = (int*)bb;
  return ( a[0] + WMAX * a[1] - (b[0] + WMAX * b[1]));
}

void fold(int *na, int a[NPMAX], int f, char d)
{
  d -= 'x';
  //printf("along %x at %d\n", d, f);
  for (int i = 0; i < *na; i += 2)
    if (a[i+d] > f)
      a[i+d] = 2 * f - a[i+d];
  int i = 0;
  for (int j = 0; j < *na; j += 2)
    if (a[j + d] != f)
      {
        a[i] = a[j]; a[i+1] = a[j+1];
        i += 2;
      }
  qsort(a, *na/2, 2*sizeof(int), compar);
  i = 2;
  for (int j = 2; j < *na; j += 2)
    {
      if(!((a[i-2] == a[j]) && (a[i+1-2] == a[j+1])))
        {
          //printf("%d %d %d %d %d %d\n", i,j,a[i-2],a[j],a[i+1],a[j+1]);
          a[i] = a[j]; a[i+1] = a[j+1];
          i += 2;
        }
    }
  *na = i;
}

int main(int argc, char *argv[])
{
  int na, a[NPMAX], nf, f[NFMAX];
  char d[NFMAX];
  init(&na, a, &nf, f, d);
  fold(&na, a, f[0], d[0]);
  printf("%d\n", na/2);
  for (int i = 1; i < nf; i++)
    fold(&na, a, f[i], d[i]);
  //printa(na, a);
  //printf("%d\n", na/2);
  int p = 0;
  for (int j = 0; j < 6; j++)
    {
      for (int i = 0; i < 40; i++)
        if (a[p] == i && a[p+1] == j)
          {
            putchar('#');
            p += 2;
          }
        else
          {
            putchar('.');
          }
      putchar('\n');
    }
  return(0);
}
