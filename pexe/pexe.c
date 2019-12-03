#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

/*

  pexe

  pexe is a MPI program that reads command lines from stdin and distributes
  them to MPI tasks. Each MPI task runs it's command lines one by one with
  system() call.

  pexe uses environment variable WRKDIR for a temporary file. WRKDIR should
  point to a directory that is visible to all processes.

  Build example:

      mpicc -o pexe -std=c11 -Wall -Wl,--as-needed pexe.c

  Usage example:

      for ((i = 0; i < 23; i++)); do
          echo sleep $(( ((i+1)%3) * ((i+2)%3) ))'; echo "Rank ${SLURM_PROCID}, line '$i': $(date +%T)"'
      done | srun -p test -t 1 -n 3 pexe

*/

#define MAX_COMMANDS 10000 // In total
#define MAX_COMMAND_LEN 256
#define MAX_FILE_NAME_LEN 256
#define TMPFILE_PREFIX "pexe-tmp-"

#ifdef NDEBUG
#define debug(...) ((void)0)
#else
#define debug(...) printf(__VA_ARGS__); fflush(stdout)
#endif

FILE *new_tmpfile (const char *path, const char *prefix,
                   char *fname) {
  const size_t tmplen = strlen (path);
  if (tmplen < MAX_FILE_NAME_LEN - 16 ) {
    strcpy (fname, path);
    if (path[tmplen-1] == '/') {
      strcpy (fname + tmplen, TMPFILE_PREFIX "XXXXXX");
    } else {
      strcpy (fname + tmplen, "/" TMPFILE_PREFIX "XXXXXX");
    }
  } else {
    MPI_Abort (MPI_COMM_WORLD, 1);
  }
  int fd = mkstemp (fname);
  if ( fd == -1 ) MPI_Abort (MPI_COMM_WORLD, 2);
  return fdopen (fd, "w");
}

void buffer_stdin_to_file (const char *path, const char *prefix,
                           char *fname) {
  FILE *tmpfile = new_tmpfile (path, prefix, fname);
  char line[MAX_COMMAND_LEN + 1] = {0};
  int i;
  while (fgets (line, MAX_COMMAND_LEN + 1, stdin) != NULL) {
    if (i >= MAX_COMMANDS) {
      fprintf (stderr, "MAX_COMMANDS (%d) exceeded.\n", i);
      MPI_Abort (MPI_COMM_WORLD, 3);
    }
    if (strlen (line) > MAX_COMMAND_LEN - 1) {
      fprintf (stderr, "MAX_COMMAND_LEN exceeded, line %d: %s\n",
               i, line);
      MPI_Abort (MPI_COMM_WORLD, 4);
    }
    fwrite (line, 1, MAX_COMMAND_LEN, tmpfile);
    memset(line, 0, sizeof(line));
    i++;
  }
  fclose (tmpfile);
}

int main(int argc, char *argv[]) {
  int rank;
  char fname[MAX_FILE_NAME_LEN];

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &rank);

  if (rank == 0)
    buffer_stdin_to_file (getenv("WRKDIR"), TMPFILE_PREFIX, fname);

  MPI_Bcast (fname, MAX_FILE_NAME_LEN, MPI_CHAR, 0, MPI_COMM_WORLD);

  MPI_File tmpfile;
  MPI_File_open (MPI_COMM_WORLD, fname,
                 MPI_MODE_RDONLY |  MPI_MODE_DELETE_ON_CLOSE, MPI_INFO_NULL,
                 &tmpfile);

  char command[MAX_COMMAND_LEN];
  MPI_Status status;
  while (!MPI_File_read_shared(tmpfile, command, MAX_COMMAND_LEN,
                              MPI_CHAR, &status)) {
    printf ("Rank: %d, Command: %s\n", rank, command);
    system (command);
  }
  debug("Rank %d closing.\n", rank);
  MPI_File_close (&tmpfile);
  MPI_Finalize ();
  exit (0);
}

/* Local variables: */
/* flycheck-gcc-include-path: /appl/opt/cluster_studio_xe2016/compilers_and_libraries_2016.0.109/linux/mpi/intel64/include */
/* End: */
