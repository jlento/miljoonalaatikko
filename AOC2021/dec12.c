//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NVERTEXMAX 100
#define NEDGEMAX 8
#define NAMEMAX 8
#define SLENMAX 1024

struct Vertex
{
  int nlist[NEDGEMAX];
  int nnlist;
  int visited;
  char name[NAMEMAX];
};
typedef struct Vertex Vertex;

int nv = 0;
Vertex v[NVERTEXMAX] = {0};

// ------
struct Stack {
  int head;
  int buf[SLENMAX];
};
typedef struct Stack Stack;
void init_stack(Stack *s)
{
  s->head = 0;
}
void push(Stack *s, int p)
{
  if (s->head < SLENMAX) s->buf[s->head++] = p;
  else exit(10);
  //printf("Push:");
  //for (int i = 0; i < s->head; i++)
  //  printf(" %s", v[s->buf[i]].name);
  //putchar('\n');
}
int is_empty_stack(Stack *s)
{
  return(!s->head);
}
int pop(Stack *s)
{
  int p;
  if (is_empty_stack(s)) exit(11);
  else p = s->buf[--s->head];
  //printf("Pop (%s):", v[p].name);
  //for (int i = 0; i < s->head; i++)
  //  printf(" %s", v[s->buf[i]].name);
  //putchar('\n');
  return(p);
}
int is_in_stack(Stack *s, int n)
{
  for (int i = 0; i < s->head; i++)
    if (n == s->buf[i]) return(1);
  return(0);
}
// -----------

int vid(char n[NAMEMAX])
{
  for (int i = 0; i < nv; i++)
    if (!strcmp(v[i].name, n)) return(i);
  return(-1);
}

void read_graph()
{
  int n = 0;
  char s0[NAMEMAX] = {0}, s1[NAMEMAX] = {0};
  int v0 = 0, v1 = 0;
  while((n = scanf("%7[^-]-%7s\n", s0, s1)) != EOF)
  {
    if (n != 2 || nv > NVERTEXMAX-2) exit(1);
    v0 = vid(s0); v1 = vid(s1);
    if (v0 < 0) { v0=nv; strncpy(v[nv++].name, s0, NAMEMAX); };
    if (v1 < 0) { v1=nv; strncpy(v[nv++].name, s1, NAMEMAX); };
    if (v[v0].nnlist > NEDGEMAX) exit(2);
    v[v0].nlist[v[v0].nnlist++] = v1;
    if (v[v1].nnlist > NEDGEMAX) exit(3);
    v[v1].nlist[v[v1].nnlist++] = v0;
  }
}

int is_low_case(char c)
{
  return(96 < c && c < 123);
}

int dfs(Stack *p, Stack *d, int i, int b)
{
  int s = 0;
  if (i == vid("end"))
    {
      //printf("Path:");
      //for (int j = 0; j < p->head; j++)
      //  printf("%s ", v[p->buf[j]].name);
      if (b)
        for (int j = 1; j < p->head; j++)
          {
          if (is_low_case(v[p->buf[j]].name[0]))
            s--;
          }
      s++;
      //printf("end %d\n", s);
      return(s);
    }
  push(p, i);
  if (is_low_case(v[i].name[0]) && b == 1 && strcmp(v[i].name, "start"))
    {
      for (int j = 0; j < v[i].nnlist; j++)
        if (!is_in_stack(d, v[i].nlist[j]))
          s += dfs(p, d, v[i].nlist[j], b-1);
    }
  if (is_low_case(v[i].name[0]))
    push(d, i);
  for (int j = 0; j < v[i].nnlist; j++)
    if (!is_in_stack(d, v[i].nlist[j]))
      s += dfs(p, d, v[i].nlist[j], b);
  pop(p);
  if (is_low_case(v[i].name[0]))
    pop(d);
  return(s);
}

int main(int argc, char *argv[])
{
  read_graph();
  /* for (int i = 0; i < nv; i++) */
  /*   { */
  /*     printf("%s", v[i].name); */
  /*     for (int j = 0; j < v[i].nnlist; j++) */
  /*       printf(" %d", v[i].nlist[j]); */
  /*     putchar('\n'); */
  /*   } */
  Stack p, d;
  init_stack(&p);
  init_stack(&d);
  int s = dfs(&p, &d, vid("start"), 0);
  printf("%d\n", s);
  init_stack(&p);
  init_stack(&d);
  s = dfs(&p, &d, vid("start"), 1);
  printf("%d\n", s);
  return(0);
}
