//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>
#include <assert.h>

#define ALGOSIZE 512
#define HALO 51


typedef unsigned char * BitArray;


void setbit (BitArray a, int i)
{
  a[i/8] |= 1 << (7 - i % 8);
}


void clearbit (BitArray a, int i)
{
  a[i/8] &= ~(1 << (7 - i % 8));
}


int getbit (BitArray a, int i)
{
  return (a[i/8] >> (7 - i % 8)) & 1;
}


BitArray new_algo ()
{
  BitArray algo = calloc(512/8, sizeof (unsigned char));
  char c = 0;
  int i = 0;
  while ((c = getchar()) != '\n') {
    assert (i < ALGOSIZE);
    putchar(c);
    if (c == '#')
      setbit(algo, i++);
    else if (c == '.')
      i++;
    else
      exit(77); }
  printf("\n");
  getchar();
  for (i = 0; i < 512; i++)
    printf("%d", getbit(algo, i));
  printf("\n");
  return algo;
}


struct Image
{
  int m, n;
  BitArray d;
};
typedef struct Image Image;


Image *new_image(m, n)
{
  Image *im = calloc(1, sizeof (*im));
  im->m = m;
  im->n = n;
  int b = im->m * im->n;
  im->d = calloc((b + 7)/8, sizeof (unsigned char));
  return im;
}

void print_image (Image *im)
{
  for (int j = 0; j < im->n; j++) {
    for (int i = 0; i < im->m; i++)
      printf("%d", getbit(im->d, im->m * j + i));
    printf("\n"); }
  printf("\n");
}

int lit_pixels (Image *im)
{
  int n = 0;
  for (int i = 0; i < im->m *im->n; i++)
    n += getbit(im->d, i);
  return n;
}

void read_image (Image *im, int halo)
{
  char *line = NULL;
  size_t linecap = 0;
  ssize_t linelen;
  while ((linelen = getline(&line, &linecap, stdin)) > -1) {
    if (linelen < 5) continue;
    if (im->n < 1) {
      im->m = linelen - 1 + 2 * halo;
      im->n = halo;
      int b = im->m * im->n;
      im->d = realloc(im->d, (b + 7) / 8 * sizeof (unsigned char));
      for (int i = 0; i < (b + 7) / 8; i++)
        im->d[i] = 0; }
    (im->n)++;
    int b = im->m * im->n;
    im->d = realloc(im->d, (b + 7)/8 * sizeof (unsigned char));
    for (int i = (im->n - 1) * im->m; i < im->m * im->n; i++)
      clearbit(im->d, i);
    for (int i = 0; i < linelen; i++)
      if (line[i] == '#')
        setbit (im->d, (im->n - 1) * im->m + i + halo); }
  free(line);
  im->n += halo;
  int b = (im->m) * im->n;
  im->d = realloc(im->d, (b + 7)/8 * sizeof (unsigned char));
  for (int i = (im->n - halo) * im->m; i < im->m * im->n; i++)
    clearbit(im->d, i);
}


int boxval (Image *im, int i, int j)
{
  int b = im->m * j + i;
  int bm = im->m * (j - 1) + i;
  int bp = im->m * (j + 1) + i;
  return
    + (getbit(im->d, bm - 1) << 8)
    + (getbit(im->d, bm    ) << 7)
    + (getbit(im->d, bm + 1) << 6)
    + (getbit(im->d, b - 1 ) << 5)
    + (getbit(im->d, b     ) << 4)
    + (getbit(im->d, b + 1 ) << 3)
    + (getbit(im->d, bp - 1) << 2)
    + (getbit(im->d, bp    ) << 1)
    + (getbit(im->d, bp + 1)     )
    ;
}

void enhance (Image *im1, Image *im0, BitArray algo)
{
  assert(im0->m == im1->m);
  assert(im0->n == im1->n);
  int b = im1->m * im1->n;
  memset(im1->d, 0, (b + 7) / 8);
  for (int j = 1; j < im1->n - 1; j++)
    for (int i = 1; i < im1->m - 1; i++)
      if (getbit (algo, boxval (im0, i, j)))
        setbit (im1->d, im1->m * j + i);
  if (getbit(algo, getbit(im0->d, 0) * 511)) {
    for (int i = 0; i < im1->m; i++)
      setbit (im1->d, i);
    for (int i = 0; i < im1->m; i++)
      setbit (im1->d, (im1->n - 1) * im1->m + i);
    for (int i = 0; i < im1->n; i++)
      setbit (im1->d, im1->m * i);
    for (int i = 0; i < im1->n; i++)
      setbit (im1->d, im1->m * (i + 1) - 1); }
  else {
    for (int i = 0; i < im1->m; i++)
      clearbit (im1->d, i);
    for (int i = 0; i < im1->m; i++)
      clearbit (im1->d, (im1->n - 1) * im1->m + i);
    for (int i = 0; i < im1->n; i++)
      clearbit (im1->d, im1->m * i);
    for (int i = 0; i < im1->n; i++)
      clearbit (im1->d, im1->m * (i + 1) - 1); }
}

int main(void)
{
  BitArray algo = new_algo();
  putchar('\n');
  Image *im0 = new_image(0, 0);
  read_image(im0, HALO);
  print_image(im0);
  Image *im1 = new_image(im0->m, im0->n);
  for (int i = 0; i < 2; i++) {
    enhance(im1, im0, algo);
    Image *tmp = im0;
    im0 = im1; im1 = tmp; }
  print_image(im0);
  printf("%d\n", lit_pixels(im0));
  for (int i = 0; i < 48; i++) {
    enhance(im1, im0, algo);
    Image *tmp = im0;
    im0 = im1; im1 = tmp; }
  print_image(im0);
  printf("%d\n", lit_pixels(im0));
  return 0;
}
