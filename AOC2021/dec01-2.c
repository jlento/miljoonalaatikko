//usr/bin/env cc "$0" && exec ./a.out "$0" "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

#define MAXLEN 1024

int main(int argc, char *argv[]) {

  if (argc < 3) {
    goto usage;
  }

  FILE *file = fopen(argv[2], "r");

  if (file == 0) {
    goto missing_input_file;
  }

  int64_t s = 0, r0 = 0, r1 = 0, r2 = 0, counter = -3;
  while (fscanf(file, "%" SCNd64, &r2) != EOF) {
    if(r0 + r1 + r2 > s) counter++;
    s = r0 +r1 + r2;
    r0 = r1; r1 =r2;
  }
  fclose(file);

 success:
  printf("%" PRId64 "\n", counter);
  return(0);

 usage:
  fprintf(stderr, "Usage: %s <input file>\n", argv[1]);
  return(1);

 missing_input_file:
  fprintf(stderr, "Error. Cannot open input file '%s'\n", argv[2]);
  return(1);
}
