//usr/bin/clang "$0" && exec ./a.out "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

#define MAXBITTABLE 1024*256

int main(int argc, char *argv[]) {

  char *fname = "Dec01.dat";
  FILE *file = fopen(fname, "r");

  if (file == 0) {
    fprintf(stderr, "Missing input file %s\n", fname);
    goto failure;
  }

  int64_t value;
  int64_t sum = 0;
  while (fscanf(file, "%" SCNd64, &value ) != EOF) {
    sum += value;
  }

  printf("Part 1 answer: %" PRId64 "\n", sum);

  sum = 0;
  uint64_t seen[MAXBITTABLE] = {0};
  while (1) {
    rewind(file);
    while (fscanf(file, "%" SCNd64, &value ) != EOF) {
      sum += value;
      size_t pos = sum / 64;
      if (pos >= MAXBITTABLE) {
        fprintf(stderr, "Index pos = %zu exceeds MAXBITTABLE = %d\n",
                pos, MAXBITTABLE);
        goto failure;
      }
      uint64_t entry = (uint64_t)1 << (63 - sum % 64);
      if (seen[pos] & entry) {
        goto exitloop;
      } else {
        seen[pos] |= entry;
      }
    }
  }
 exitloop:

  printf("Part 1 answer: %" PRId64 "\n", sum);

 success:
  fclose(file);
  return(0);

 failure:
  fclose(file);
  return(1);
}
