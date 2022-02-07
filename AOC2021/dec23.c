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
#include <assert.h>

#define BUFMAX 1024

#define FMT \
  "#############\n" \
  "#%c%c.%c.%c.%c.%c%c#\n" \
  "###%c#%c#%c#%c###\n" \
  "  #%c#%c#%c#%c#\n" \
  "  #########\n"

const char solved[] = ".......ABCDABCDABCDABCD";

int bestcost = INT_MAX;

void read_state (char s[15])
{
  scanf(FMT, &s[0], &s[1], &s[2], &s[3], &s[4], &s[5],
        &s[6], &s[7], &s[8], &s[9], &s[10], &s[11],
        &s[12], &s[13], &s[14]);
}


void print_state (char s[15])
{
  printf(FMT, s[0], s[1], s[2], s[3], s[4],
         s[5], s[6], s[7], s[8], s[9], s[10], s[11],
         s[12], s[13], s[14]);
}


int path[7][4][11] = {
  {
    {1, 7, 11, 15, 19},
    {1, 2, 8,  12, 16, 20},
    {1, 2, 3,   9, 13, 17, 21},
    {1, 2, 3,   4, 10, 14, 18, 22},
  }, {
    {7, 11, 15, 19},
    {2, 8,  12, 16, 20},
    {2, 3,   9, 13, 17, 21},
    {2, 3,   4, 10, 14, 18, 22},
  }, {
    {7, 11, 15, 19},
    {8, 12, 16, 20},
    {3,  9, 13, 17, 21},
    {3,  4, 10, 14, 18, 22}
  }, {
    {2,  7, 11, 15, 19},
    {8, 12, 16, 20},
    {9, 13, 17, 21},
    {4, 10, 14, 18, 22}
  }, {
    {3,   2,  7, 11, 15, 19},
    {3,   8, 12, 16, 20},
    {9,  13, 17, 21},
    {10, 14, 18, 22}
  }, {
    { 4,  3,  2,  7, 11, 15, 19},
    { 4,  3,  8, 12, 16, 20},
    { 4,  9, 13, 17, 21},
    {10, 14, 18, 22}
  }, {
    {5, 4, 3, 2, 7, 11, 15, 19},
    {5, 4, 3, 8, 12, 16, 20},
    {5, 4, 9, 13, 17, 21},
    {5, 10, 14, 18, 22}
  }
};
int npath[7][4] = {{5, 6, 7, 8}, {4, 5, 6, 7}, {4, 4, 5, 6},
               {5, 4, 4, 5}, {6, 5, 4, 4}, {7, 6, 5, 4}, {8, 7, 6, 5}};

int doorway_steps[7][4] = {
  {1, 2, 3, 4},
  {1, 2, 3, 4},
  {1, 1, 2, 3},
  {2, 1, 1, 2},
  {3, 2, 1, 1},
  {4, 3, 2, 1},
  {4, 3, 2, 1}
};

int move_to (int n, char s[n], int i, int j)
{
  int nsteps = 0;
  int *p = path[i][(j - 7) % 4];
  int nip = n == 15 ? npath[i][(j - 7) % 4] - 2 : npath[i][(j - 7) % 4];
  for (int ip = 0;;ip++)
    {
      if (ip >= nip )
        return 0;
      if (p[ip] == j) {
        nsteps++;
        break;
      }
      if (s[p[ip]] == '.')
        nsteps++;
      else
        return 0;
    }
  return nsteps + doorway_steps[i][(j - 7) % 4];
}


int is_at_home (int n, char s[n], char ss, int i)
{
  int a = ss - 'A';
  if (n == 15) {
    return i == a + 11 || (i == a + 7 && s[a + 11] == ss);
  } else {
    return i == a + 19
      || (i == a + 15 && s[a + 19] == ss)
      || (i == a + 11 && s[a+15] == ss && s[a + 19] == ss)
      || (i == a + 7  && s[a+11] == ss && s[a+15] == ss && s[a + 19] == ss);
  }
}


int move (int n, char ss[n], char s[n], int i, int j)
{
  int nsteps = 0;
  if ((i == j) || (s[i] == '.') || (s[j] != '.') || is_at_home(n, s, s[i], i)) {
    //printf("No move\n");
    return 0;
  }
  if (i < 7 && is_at_home (n, s, s[i], j)) {
    if ((nsteps = move_to (n, s, i, j))) {
      //printf("Moving to room\n");
      memcpy(ss, s, n * sizeof (char));
      ss[j] = ss[i];
      ss[i] = '.';
    }
  } else if (j < 7 && i > 6) {
    //printf("Moving to hall\n");
    if ((nsteps = move_to (n, s, j, i))) {
      memcpy(ss, s, n * sizeof (char));
      ss[j] = ss[i];
      ss[i] = '.';
    }
  }
  return nsteps;
}

void solve(int n, char s[n], int depth, int cost)
{
  // 0. Solved
  if (!memcmp(s, solved, n))
    {
      if (cost < bestcost) bestcost = cost;
      printf("Solved: depth, cost: %d, %d\n", depth, cost);
      //print_state(s);
      return;
    }

  // 1. Jump to room (always when possible)
  for (int i = 0; i < 7; i++)
    for (int j = 7; j < n; j++) {
      char ss[n];
      int c;
      if (is_at_home(n, s, s[i], j) && (c = move(n, ss, s, i, j) * (int) (pow(10,s[i] - 'A') + 0.5))) {
        if (cost + c < bestcost) {
          solve(n, ss, depth + 1, cost + c);
        }
        return;
      }
    }

  // 2. Move to hall
  for (int i = 7; i < n; i++)
    for (int j = 0; j < 7; j++) {
      char ss[n];
      int c;
      if ((c = move(n, ss, s, i, j) * (int) (pow(10,s[i] - 'A') + 0.5))) {
        if (cost + c < bestcost) {
          solve(n, ss, depth + 1, cost + c);
        }
      }
    }

  return;
}


int main(void)
{
  char s[23];
  read_state(s);
  //print_state(s);
  bestcost = INT_MAX;
  solve(15, s, 0, 0);
  bestcost = INT_MAX;
  memcpy(&s[19], &s[11], 4 * sizeof (char));
  memcpy(&s[11], "DCBADBAC", 8 * sizeof (char));
  solve(23, s, 0, 0);
}
