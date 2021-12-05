//usr/bin/env cc "$0" && exec ./a.out "$0" "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>

int main(int argc, char *argv[]) {

  if (argc < 3) {
    goto usage;
  }

  FILE *file = fopen(argv[2], "r");

  if (file == 0) {
    goto missing_input_file;
  }

  int64_t current, previous = 0, counter = -1;
  while (fscanf(file, "%" SCNd64, &current) != EOF) {
    if (current > previous) counter++;
    previous = current;
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