//usr/bin/env cc -O3 -std=c99 -O3 "$0" && exec ./a.out < ${0%.*}.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENX 100
#define LENY 100
#define HALOVALUE '9'

char g[(LENX+2)*(LENY+2)];

#define START (LENX+3)
#define STOP ((LENX+2)*(LENY+1)-1)
int next(int p)  {return((p + 2) % (LENX+2) ? p + 1 : p + 3);};
int up(int p)    {return(p - (LENX+2));};
int down(int p)  {return(p + (LENX+2));};
int left(int p)  {return(p - 1);};
int right(int p) {return(p + 1);};

void init(void)
{
  memset(g, HALOVALUE, sizeof(g));
  for (int j = 0, p = START; j < LENY; j++)
    {
      for (int i = 0; i < LENX; i++, p = next(p))
        g[p] = getchar();
      getchar();
    }
  //for (int j = 0, p = 0; j < LENY+2; j++)
  //  {
  //    for (int i = 0; i < LENX+2; i++, p++)
  //      putchar(g[p]);
  //    putchar('\n');
  //  }
}

int islow(int p)
{
  return((g[p] < g[up(p)]) &&
         (g[p] < g[left(p)]) &&
         (g[p] < g[right(p)]) &&
         (g[p] < g[down(p)]));
}

int risklevelsum(void)
{
  int s = 0;
  for (int p = START; p < STOP; p = next(p))
    if (islow(p))
      s += g[p] - '0' + 1;
  return(s);
}

#define QLEN (4*LENX)
struct Queue {
  int head;
  int tail;
  int buf[QLEN];
};
typedef struct Queue Queue;
void init_queue(Queue *q)
{
  q->head = 0;
  q->tail = 0;
}
void enqueue(Queue *q, int p)
{
  q->buf[q->tail] = p;
  q->tail = (q->tail + 1) % QLEN;
  if (q->head == q->tail) exit(10);
  //printf("IN(%d)  %d\n", q->tail, p);
}
int is_empty_queue(Queue *q)
{
  return(q->head == q->tail);
}
int dequeue(Queue *q)
{
  if (is_empty_queue(q)) exit(11);
  int p = q->buf[q->head];
  q->head = (q->head + 1) % QLEN;
  //printf("OUT(%d) %d\n", q->head, p);
  return(p);
}

int basinsize(int p)
{
  int s = 0;
  Queue q;
  init_queue(&q);
  g[p] = HALOVALUE; s++;
  enqueue(&q, p);
  while (!is_empty_queue(&q))
    {
      p = dequeue(&q);
      //printf("%c %c %c %c %c\n", g[p], g[up(p)], g[left(p)], g[right(p)], g[down(p)]);
      if (g[up(p)] != HALOVALUE) {enqueue(&q, up(p)); g[up(p)] = HALOVALUE; s++;}
      if (g[left(p)] != HALOVALUE) {enqueue(&q, left(p)); g[left(p)] = HALOVALUE; s++;}
      if (g[right(p)] != HALOVALUE) {enqueue(&q, right(p)); g[right(p)] = HALOVALUE; s++;}
      if (g[down(p)] != HALOVALUE) {enqueue(&q, down(p)); g[down(p)] = HALOVALUE; s++;}
    }
  return(s);
}

int threelargestbasins()
{
  int s[3] = {0}, ss = 0;
  for (int p = START; p < STOP; p = next(p))
      if (islow(p))
        {
          ss = basinsize(p);
          if (ss > s[0]) {s[0] = ss;}
          if (s[0] > s[1]) {ss = s[0]; s[0] = s[1]; s[1] = ss;}
          if (s[1] > s[2]) {ss = s[1]; s[1] = s[2]; s[2] = ss;}
        }
  return(s[0] * s[1] * s[2]);
}

int main(int argc, char *argv[])
{
  init();
  printf("%d\n", risklevelsum());
  printf("%d\n", threelargestbasins());
  return(0);
}
