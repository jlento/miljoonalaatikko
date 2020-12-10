//usr/bin/env cc "$0" && exec ./a.out "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdbool.h>

int main(int argc, char *argv[])
{
  char a[10000] = {0}, b[10000] = {0};
  int n = 0;
  scanf("%" SCNd8, &a[0]);
  while (scanf(",%" SCNd8, &a[++n]) != EOF);
  for (int i = 0; i < 3; i++) {
    for (int j = 97; j < 123; j++) {
      bool cycle = false;
      for (int k = i; k < n; k += 3) {
        b[k] = a[k] ^ j;
        if (b[k] < 32 || b[k] > 122 || b[k] == 64) {
          cycle = true;
          break;
        }
      }
      if (cycle) continue;
      printf("i, j: %d, %d  %c\n", i, j, j);
      break;
    }
  }
  for (int i = 0; i < n; i++) putchar(b[i]);
  putchar(10);
}
