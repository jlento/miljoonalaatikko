#define _GNU_SOURCE
#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>
#include <unistd.h>

#define MAX_COMMANDS 10000
#define MAX_COMMAND_LEN 256

#define SIZE_BTBUF 100
void print_backtrace (void) {
  int nptrs;
  void * buffer[SIZE_BTBUF];
  nptrs = backtrace (buffer, SIZE_BTBUF);
  backtrace_symbols_fd (buffer, nptrs, STDERR_FILENO);
}

#define error(...)                                                      \
  fprintf(stderr, "%s[%d]: %s:\n", __FILE__, __LINE__, __func__);       \
  fprintf(stderr, "  "__VA_ARGS__);                                     \
  print_backtrace ();                                                   \
  MPI_Abort (MPI_COMM_WORLD, 1)

#ifdef NDEBUG
#define debug(...) ((void)0)
#else
#define debug(...) printf(__VA_ARGS__);
#endif

#define info(...) if (comm_rank == 0) {printf(__VA_ARGS__);}

#define CHK(ierr)                                                       \
  if (ierr != MPI_SUCCESS) {                                            \
    int resultlen;                                                      \
    char err_buffer[MPI_MAX_ERROR_STRING];                              \
    MPI_Error_string(ierr, err_buffer, &resultlen);                     \
    error("%s\n", err_buffer);                                          \
  }

int ierr, comm_rank, comm_size;

int main(int argc, char *argv[]) {
  MPI_Win table;
  char commands[MAX_COMMANDS][MAX_COMMAND_LEN] = {0};

  ierr = MPI_Init(&argc, &argv); CHK(ierr);
  ierr = MPI_Comm_rank(MPI_COMM_WORLD, &comm_rank); CHK(ierr);
  ierr = MPI_Comm_size(MPI_COMM_WORLD, &comm_size); CHK(ierr);

  ierr = MPI_Win_create(&commands, MAX_COMMANDS * MAX_COMMAND_LEN,
                        MAX_COMMAND_LEN, MPI_INFO_NULL,
                        MPI_COMM_WORLD, &table); CHK(ierr);

  ierr = MPI_Win_fence(0, table); CHK(ierr);

  if (comm_rank == 0) {
    char line[MAX_COMMAND_LEN + 2];
    int i = 0;
    while (fgets(line, MAX_COMMAND_LEN + 2, stdin) != NULL) {
      if (strlen(line) > MAX_COMMAND_LEN) {
        error("%s\nCommand line: %s\n",
              "  Maximum command line length MAX_COMMAND_LEN exceeded",
              line);
      }
      MPI_Aint disp = (i / comm_size);
      int target_rank = (i + 1) % comm_size;
      ierr = MPI_Win_lock(MPI_LOCK_SHARED, target_rank, MPI_MODE_NOCHECK,
                          table); CHK(ierr);
      ierr = MPI_Put(line, MAX_COMMAND_LEN, MPI_CHAR, target_rank,
                     disp, MAX_COMMAND_LEN, MPI_CHAR, table); CHK(ierr);
      ierr = MPI_Win_unlock(target_rank, table); CHK(ierr);
      i++;
    }
  }

  ierr = MPI_Win_fence(0, table); CHK(ierr);

  for (int i = 0; i < MAX_COMMANDS; i++) {
    if (strlen(commands[i]) < 1) break;
    system(commands[i]);
  }

  ierr = MPI_Barrier(MPI_COMM_WORLD);

  MPI_Win_free(&table);

  MPI_Finalize();
  exit(EXIT_SUCCESS);
}
