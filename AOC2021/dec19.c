//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>
#include <math.h>
#include "vvector.h"

#define NSCANNERSMAX 32
#define NDATAMAX 32


struct Scanner
{
  int n;
  int (*x)[3];
  int (*d)[NDATAMAX-1];
};
typedef struct Scanner Scanner;


int intcmp (const void * a, const void * b) {
  return ( *(int*)a - *(int*)b );
}


int int3cmp (const void * a, const void * b) {
  int d = 0;
  if (!(d = ((int*)a)[0] - ((int*)b)[0]))
    if (!(d = ((int*)a)[1] - ((int*)b)[1]))
      d = ((int*)a)[2] - ((int*)b)[2];
  return d;
}


int dmanhattan (int a[3], int b[3])
{
  return abs (a[0] - b[0]) + abs (a[1] - b[1]) + abs (a[2] - b[2]);
}


void free_scanner (Scanner *scanner)
{
  free (scanner->x);
  free (scanner->d);
  free (scanner);
}


int read_scanner (Scanner *s)
{
  int *n = &s->n;
  int (*x)[3] = s->x;
  int nitems;
  while ((nitems = scanf ("%d,%d,%d\n", &x[*n][0], &x[(*n)][1], &x[(*n)][2])) != EOF) {
      if (nitems > 2)
        (*n)++;
      else if (*n > 0)
        break;
      else
        scanf ("%*s\n");
      if (*n > NDATAMAX - 1) exit(11); }
  return *n;
}


void compute_fingerprint (Scanner *s)
{
  int n = s->n;
  int (*x)[3] = s->x;
  int (*d)[NDATAMAX - 1] = s->d;
  for (int j = 0; j < (s->n); j++) {
      int nn = 0;
      for (int i = 0; i < n; i++)
        if (i != j)
          d[j][nn++] =
            dmanhattan (x[j], x[i]);
      qsort (d[j], n - 1, sizeof(int), intcmp); }
}


Scanner *new_scanner ()
{
  Scanner *s = malloc (sizeof (Scanner));
  s->x = calloc (3*NDATAMAX, sizeof(int));
  s->d = calloc (NDATAMAX * (NDATAMAX - 1), sizeof (int));
  s->n = 0;
  if (!read_scanner (s)) {
      free_scanner (s);
      return 0; }
  compute_fingerprint (s);
  return s;
}


void print_scanner (const Scanner *scanner)
{
  int n = scanner->n;
  for (int j = 0; j < n; j++) {
      for (int i = 0; i < 3; i++)
        printf ("%6d", scanner->x[j][i]);
      for (int i = 0; i < NDATAMAX - 1; i++)
        printf ("%5d", scanner->d[j][i]);
      printf ("\n"); }
  printf ("\n");
}


int correlation (int n0, int nd0[n0], int n1, int nd1[n1])
{
  int i0 = 0, i1 = 0, c = 0;
  int n = n0 < n1 ? n0 : n1;
  while (i0 < n && i1 < n && nd0[i0] > 0 && nd1[i1] > 0) {
      if (nd0[i0] == nd1[i1])
        {c++; i0++; i1++;}
      else if (nd0[i0] > nd1[i1])
        i1++;
      else
        i0++; }
  return c;
}


void select_points (Scanner *s0, Scanner *s1,
                    int m0[NSCANNERSMAX*NDATAMAX],
                    int m1[NSCANNERSMAX*NDATAMAX],
                    int *nm)
{
  int n0 = s0->n;
  int n1 = s1->n;
  *nm = 0;
  for (int j = 0; j < n0; j++)
      for (int i = 0; i < n1; i++) {
          if (correlation (n0 - 1, s0->d[j], n1 - 1, s1->d[i]) > 10) {
              m0[*nm] = j;
              m1[*nm] = i;
              (*nm)++; } }
}


void compute_rotation(int rot[3][3],
                     Scanner *s0,
                     Scanner *s1,
                     int m0[NSCANNERSMAX*NDATAMAX],
                     int m1[NSCANNERSMAX*NDATAMAX])
{
  int (*x0)[3] = s0->x;
  int (*x1)[3] = s1->x;
  double x[3][3] = {0};
  double xp[3][3] = {0};
  double det = 0;
  double invxp[3][3];
  double drot[3][3];
  for (int j = 0; j < 3; j++)
    for (int i = 0; i < 3; i++) {
      x[i][j] = x0[m0[j+1]][i] - x0[m0[0]][i];
      xp[i][j] = x1[m1[j+1]][i] - x1[m1[0]][i]; }
  INVERT_3X3(invxp, det, xp);
  if (fabs(det) < 1) exit(66);
  MATRIX_PRODUCT_3X3(drot, x, invxp);
  DETERMINANT_3X3(det, drot);
  if (fabs(det) < 0.9 || fabs(det) > 1.1) exit(67);
  /* MAT_PRINT_3X3(drot); */
  for (int j = 0; j < 3; j++)
    for (int i = 0; i < 3; i++)
      rot[j][i] = round(drot[j][i]);
}


int align (int *ntranslations, int translation[NSCANNERSMAX][3], Scanner *s0, Scanner *s1)
{
  int nm = 0, m0[NSCANNERSMAX * NDATAMAX] = {0};
  int m1[NSCANNERSMAX * NDATAMAX] = {0};
  int (*x0)[3] = s0->x;
  int (*x1)[3] = s1->x;
  select_points (s0, s1, m0, m1, &nm);
  if (nm < 12) return 0;
  int rot[3][3] = {0};
  compute_rotation (rot, s0, s1, m0, m1);
  int rxp[3] = {0};
  MAT_DOT_VEC_3X3 (rxp, rot, x1[m1[0]]);
  VEC_DIFF (translation[*ntranslations], x0[m0[0]], rxp);
  s0->x = realloc (s0->x, 3 * (s0->n + s1->n) * sizeof (int));
  s0->d = realloc (s0->d, (NDATAMAX - 1 ) * (s0->n + s1->n) * sizeof (int));
  for (int j = 0; j < s1->n; j++) {
    int xp[3] = {0};
    MAT_DOT_VEC_3X3 (xp, rot, x1[j]);
    VEC_SUM (s0->x[s0->n], xp, translation[*ntranslations]);
    memcpy (s0->d[s0->n], s1->d[j], (NDATAMAX - 1) * sizeof (int));
    (s0->n)++; }
  (*ntranslations)++;
  return 1;
}


void unique_points (int *npoints, int points[NSCANNERSMAX*NDATAMAX][3], Scanner *s)
{
  for (int i = 0; i < s->n; i++) {
    points[i][0] = s->x[i][0];
    points[i][1] = s->x[i][1];
    points[i][2] = s->x[i][2]; }
  qsort(points, s->n, 3 * sizeof (int), int3cmp);
  *npoints = 0;
  for (int i = 1; i < s->n; i++)
    if (int3cmp (points[i], points[*npoints])) {
      (*npoints)++;
      points[*npoints][0] = points[i][0];
      points[*npoints][1] = points[i][1];
      points[*npoints][2] = points[i][2]; }
  (*npoints)++;
}


int main(void)
{
  Scanner *scanner[NSCANNERSMAX];
  int nscanners = 0;
  for (;;) {
    if (nscanners >= NSCANNERSMAX) exit(1);
    if ((scanner[nscanners] = new_scanner()) == 0)
      break;
    //print_scanner(scanner[nscanners]);
    nscanners++;
  }
  int i = 0, n = nscanners;
  int alligned[NSCANNERSMAX] = {0};
  int ntranslations = 0;
  int translation[NSCANNERSMAX][3];
  alligned[0] = 1;
  while (n > 1) {
    if ((!alligned[i]) &&
        align(&ntranslations, translation, scanner[0], scanner[i])) {
      alligned[i] = 1;
      free_scanner(scanner[i]);
      n--; }
    i = (i + 1) % nscanners; }
  int npoints = 0, points[NSCANNERSMAX*NDATAMAX][3] = {0};
  unique_points (&npoints, points, scanner[0]);
  printf("%d\n", npoints);
  /* for (int i = 0; i < npoints; i++) */
  /*   printf("%6d%6d%6d\n", points[i][0], points[i][1], points[i][2]); */
  int m = 0, d = 0;
  for (int i = 0; i < ntranslations; i++)
    for (int j = 0; j < i; j++)
      if ((d = dmanhattan (translation[i], translation[j])) > m)
        m = d;
  printf("%d\n", m);
  return 0;
}
