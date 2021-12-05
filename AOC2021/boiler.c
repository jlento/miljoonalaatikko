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

  int64_t value;
  while (fscanf(file, "%" SCNd64, &value ) != EOF) {
    printf("%" PRId64 "\n", value);
  }

 success:
  printf("");
  return(0);
  
 usage:
  fprintf(stderr, "Usage: %s <input file>\n", argv[1]);
  return(1);

 missing_input_file:
  fprintf(stderr, "Error. Cannot open input file '%s'\n", argv[2]);
  return(1);
}
