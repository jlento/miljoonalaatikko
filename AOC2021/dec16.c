//usr/bin/env cc -O0 -g -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O3 -std=c99 "$0" && exec ./a.out < ${0%.*}.txt
//usr/bin/env cc -O0 -g -std=c99 "$0"  && exec ./a.out < foo.txt
// Add compile option (clang) `-Rpass=inline` for fun :)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <inttypes.h>

#define BUFMAX 2048
#define ARRMAX 64

#define ERR(s) do { fprintf(stderr, "s"); exit(1); } while (0)

struct Bits
{
  int p, n, vs;
  unsigned char *d;
};
typedef struct Bits Bits;

Bits new_bits(int n, char *s)
{
  Bits b;
  unsigned int c;
  b.p = 0;
  b.vs = 0;
  b.n = n;
  b.d = calloc(n, sizeof(unsigned char));
  for (int i = 0; i < n; i++, s += 2)
    {
      sscanf(s, "%2X", &c);
      b.d[i] = (unsigned char) c;
    }
  return b;
}

void printb(unsigned char b)
{
  for(int i = 7; i >= 0; i--)
    putchar('0' + ((b >> i) & 1));
}

void printbits(Bits bs)
{
  for (int i = 0; i < bs.n; i++)
    printb(bs.d[i]);
  putchar('\n');
}

void printn(uint64_t v, int n)
{
  for (int i = n - 1; i >= 0; i--)
    putchar('0' + ((v & (1 << i)) >> i));
  putchar(' ');
}

uint64_t pop(Bits *bs, int m)
{
  int cn = bs->p / 8;
  if (cn + 1 > bs->n) ERR("Pop from empty");
  uint64_t x = 0;
  for (int i = 0; (i < 8) && (cn + i < bs->n); i++)
    x += (uint64_t) bs->d[cn + i] << (8 * (7 - i));
  x <<= (bs->p % 8);
  bs->p += m;
  return x >> (64 - m);
}

uint64_t pop_packet(Bits *bs);

uint64_t pop_value (Bits *bs)
{
  uint64_t v = 0, vv;
  for (int i = 0;; i++)
    {
      if (i > 15) ERR("Error: too large value\n");
      vv = pop(bs, 5);
      printn(vv, 5);
      v <<= 4;
      v += vv & 15;
      if (vv < 16)
        break;
    }
  printf(") ");
  return v;
}

uint64_t pop_operator(Bits *bs, int type)
{
  uint64_t r = 0;
  uint64_t arr[ARRMAX] = {0}, na = 0;
  int i = pop(bs, 1);
  printn(i, 1);
  switch (i)
    {
      int l;
    case 0:
      l = pop(bs, 15);
      printn(l, 15);
      int nbm = bs->p + l;
      while ((bs->p / 8 + 1 < bs->n) && !((nbm - bs->p < 11)) )
        {
          if (ARRMAX - na < 1) ERR("Increase ARRMAX\n");
          arr[na++]= pop_packet(bs);
        }
      bs->p = nbm;
      break;
    case 1:
      l = pop(bs, 11);
      printn(l, 11);
      printf("N%d ", l);
      for (int j = 0; j < l; j++)
        {
          if (ARRMAX - na < 1) ERR("Increase ARRMAX\n");
          arr[na++] = pop_packet(bs);
        }
      break;
    }
  printf(") ");
  switch (type)
    {
    case 0:
      for (int j = 0; j < na; j++)
        r += arr[j];
      break;
    case 1:
      r = 1;
      for (int j = 0; j < na; j++)
        r *= arr[j];
      break;
    case 2:
      r = UINT64_MAX;
      for (int j = 0; j < na; j++)
        r = arr[j] < r ? arr[j] : r;
      break;
    case 3:
      r = 0;
      for (int j = 0; j < na; j++)
        r = arr[j] > r ? arr[j] : r;
      break;
    case 5:
      r = arr[0] > arr[1];
      break;
    case 6:
      r = arr[0] < arr[1];
      break;
    case 7:
      r = (arr[0] == arr[1]) ? 1 : 0;
      break;
    default:
      ERR("Bad type");
    }
  return r;
}

uint64_t pop_packet(Bits *bs)
{
  int v, t = 0;
  uint64_t r = 0;
  if (8*bs->n - bs->p < 11) return r;
  v = pop(bs, 3); bs->vs += v;
  t = pop(bs, 3);
  printf("( "); printn(v, 3); printn(t, 3);
  switch (t)
    {
    case 4:
      r = pop_value(bs);
      break;
    default:
      r = pop_operator(bs, t);
    }
  return r;
}

void run(char *s)
{
  Bits bs = new_bits(strlen(s)/2, s);
  uint64_t r = 0;
  printf("%s\n", s);
  r = pop_packet(&bs);
  printf("\n%d ", bs.vs);
  printf("%llu\n\n", r);
}

int main(int argc, char *argv[])
{
  run ("D2FE28");
  run ("38006F45291200");
  run ("EE00D40C823060");
  run ("8A004A801A8002F478");
  run ("620080001611562C8802118E34");
  run ("C0015000016115A2E0802F182340");
  run ("A0016C880162017C3686B18A3D4780");
  run ("C200B40A82");
  run ("04005AC33890");
  run ("880086C3E88112");
  run ("CE00C43D881120");
  run ("D8005AC2A8F0");
  run ("F600BC2D8F");
  run ("9C005AC2F8F0");
  run ("9C0141080250320F1802104A08");

  char s[BUFMAX] = {0};
  fgets(s, BUFMAX - 1, stdin);
  run (s);
}
