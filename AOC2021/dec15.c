//usr/bin/env cc -O3 -std=c99 -I . ./ccan/heap/heap.c "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 -I . ./ccan/heap/heap.c "$0"  && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <ccan/heap/heap.h>

#define XMAX 100
#define YMAX 100

struct Vertex { int w, d; };
typedef struct Vertex Vertex;

struct SquareGridGraph
{
  int nx, ny, n;
  Vertex *v;
};
typedef struct SquareGridGraph SGGraph;

SGGraph *new_sggraph (int nx, int ny)
{
  SGGraph *g = malloc (sizeof *g);
  g->nx = nx;
  g->ny = ny;
  g->n  = nx * ny;
  g->v  = calloc (nx * ny, sizeof(g->v));
  return g;
}

Vertex *up (SGGraph *g, Vertex *v)
{
  return (v - g->v) > g->nx - 1 ? v - g->nx : 0;
};

Vertex *down (SGGraph *g, Vertex *v)
{
  return (v - g->v) < g->n - g->nx ? v + g->nx : 0;
};

Vertex *left (SGGraph *g, Vertex *v)
{
  return (v - g->v) % g->nx ? v - 1 : 0;
};

Vertex *right (SGGraph *g, Vertex *v)
{
  return (v - g->v + 1) % g->nx ? v + 1 : 0;
};

void init(SGGraph *g, SGGraph *g5)
{
  Vertex *v = g->v;
  while(v < &g->v[g->n])
    {
      char c = getchar();
      if (c == EOF) exit(10);
      if (c != '\n')
        {
          v->w = c - '0';
          v->d = INT_MAX;
          v++;
        }
    }
  for (int kj = 0; kj < 5; kj++)
    for (int ki = 0; ki < 5; ki++)
      {
        for (int j = 0; j < g->ny; j++)
          for (int i = 0; i < g->nx; i++)
            {
              int x = i + g->nx * ki;
              int y = j + g->nx * kj;
              int w = g->v[i + g->nx *j].w + ki + kj ;
              g5->v[x + g5->nx * y].w = w % 10 + w / 10;
              g5->v[x + g5->nx * y].d = INT_MAX;
            }
      }
}

void printg(SGGraph *g, char property)
{
  int i = 0;
  for (Vertex *v = g->v; v < &g->v[g->n]; v++)
    {
      switch(property)
        {
        case 'd':
          printf("%3d", v->d);
          break;
        default:
          printf("%1d", v->w);
          break;
        }
      if(!(++i % g->nx)) putchar('\n');
    }
}

static bool less(const Vertex *i, const Vertex *j)
{
  return i->d < j->d;
}

static bool __less(const void *i, const void *j)
{
  return less(i, j);
}

void update(SGGraph *g, struct heap *q, Vertex *v, Vertex *u)
{
  int d = v->d + u->w;
  if (d < u->d)
    {
      u->d = d;
      heap_decrease(q, u);
    }
}

void dijkstra(SGGraph *g)
{
  struct heap *q = heap_init(__less);
  if (q == NULL) {perror ("heap alloc"); exit(1); }
  for (Vertex *v = g->v;  v < &g->v[g->n]; v++)
    if (heap_push(q, v)) {perror ("heap push"); exit(1); }

  g->v[0].d = 0;
  Vertex *v = 0, *u = 0;
  while(q->len)
     {
       v = heap_pop (q);
       v->w = 0;
       if ((u = up(g, v)))    update(g, q, v, u);
       if ((u = left(g, v)))  update(g, q, v, u);
       if ((u = right(g, v))) update(g, q, v, u);
       if ((u = down(g, v)))  update(g, q, v, u);
     }
  heap_free(q);
}

int main(int argc, char *argv[])
{
  SGGraph *G = new_sggraph(XMAX, YMAX);
  SGGraph *G5 = new_sggraph(5*XMAX, 5*YMAX);
  init(G, G5);
  //printg(G, 'w');
  dijkstra(G);
  printf("%d\n", G->v[G->n - 1].d); fflush(stdout);
  //printg(G5, 'w');
  dijkstra(G5);
  printf("%d\n", G5->v[G5->n - 1].d);
}
