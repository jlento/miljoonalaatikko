#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

int main(int argc, char *argv[]) {

  char *fname = "Dec01.dat";
  FILE *file = fopen(fname, "r");

  if (file == 0) {
    fprintf(stderr, "Missing input file %s\n", fname);
    return(1);
  }

  int64_t value;
  int64_t sum = 0;
  while (fscanf(file, "%" SCNd64, &value ) != EOF) {
    sum += value;
  }

  printf("Part 1 answer: %" PRId64 "\n", sum);

  int64_t seen[1024*256] = {0};

  fclose(file);

}
