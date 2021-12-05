//usr/bin/env cc "$0" && exec ./a.out "$0" "$@"

#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <string.h>

#define MAXLEN 1024

int main(int argc, char *argv[]) {

  if (argc < 3) {
    goto usage;
  }

  FILE *file = fopen(argv[2], "r");

  if (file == 0) {
    goto missing_input_file;
  }

  int64_t n, f = 0, u = 0, d = 0;
  char line[MAXLEN];
  char *token;
  while (fgets(line, MAXLEN, file)) {
    token = strtok(line, " ");
    sscanf(strtok(0, " "), "%" SCNd64, &n);
    switch (*token) {
    case 'f':
      f += n;
      break;
    case 'u':
      u += n;
      break;
    case 'd':
      d += n;
      break;
    }
  }
  fclose(file);

 success:
  printf("%" PRId64 "\n", f * (d - u));
  return(0);

 usage:
  fprintf(stderr, "Usage: %s <input file>\n", argv[1]);
  return(1);

 missing_input_file:
  fprintf(stderr, "Error. Cannot open input file '%s'\n", argv[2]);
  return(1);
}
