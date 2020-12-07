//usr/bin/env cc "$0" && exec ./a.out "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

#define MAXBITTABLE 1024*256

int main(int argc, char *argv[]) {

  char *fname = "Dec01.dat";
  FILE *file = fopen(fname, "r");

  if (file == 0) {
    goto missing_input_file;
  }

  int64_t value;
  int64_t sum1 = 0;
  while (fscanf(file, "%" SCNd64, &value ) != EOF) {
    sum1 += value;
  }

  int64_t sum2 = 0;
  uint64_t seen[MAXBITTABLE] = {0};
  size_t pos;
  while (1) {
    rewind(file);
    while (fscanf(file, "%" SCNd64, &value ) != EOF) {
      sum2 += value;
      pos = sum2 / 64;
      if (pos >= MAXBITTABLE) {
        goto array_overflow;
      }
      uint64_t entry = (uint64_t)1 << (63 - sum2 % 64);
      if (seen[pos] & entry) {
        goto success;
      } else {
        seen[pos] |= entry;
      }
    }
  }

 success:
  printf("Part 1 answer: %" PRId64 "\n", sum1);
  printf("Part 2 answer: %" PRId64 "\n", sum2);
  fclose(file);
  return(0);

 missing_input_file:
  fprintf(stderr, "Missing input file %s\n", fname);
  return(1);

 array_overflow:
  fprintf(stderr, "Index pos = %zu exceeds MAXBITTABLE = %d\n",
          pos, MAXBITTABLE);
  fclose(file);
  return(2);
}
