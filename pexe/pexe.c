#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

/*

  pexe

  pexe is a MPI program that reads command lines from stdin and distributes
  them to MPI tasks. Each MPI task runs it's command lines one by one with
  system() call.

  Build example:

      mpicc -o pexe -std=c11 -Wall pexe.c

  Usage example:

      for ((i = 0; i < 7; i++)); do
          echo echo \"Line $i, Host \$\(hostname\), Rank \${SLURM_PROCID}.\"
      done | srun -p test -t 1 -n 3 --tasks-per-node=2 pexe | sort -n -k 2

  TODO:
  - work stealing

*/

#define MAX_COMMANDS 10000  // ...per task
#define MAX_COMMAND_LEN 256

int main(int argc, char *argv[]) {
  MPI_Win table;
  char commands[MAX_COMMANDS][MAX_COMMAND_LEN] = {0};
  int comm_rank, comm_size;

  MPI_Init (&argc, &argv);
  MPI_Comm_rank (MPI_COMM_WORLD, &comm_rank);
  MPI_Comm_size (MPI_COMM_WORLD, &comm_size);

  MPI_Win_create (&commands, MAX_COMMANDS * MAX_COMMAND_LEN, MAX_COMMAND_LEN,
                 MPI_INFO_NULL, MPI_COMM_WORLD, &table);

  MPI_Win_fence (0, table);

  // Distribute command lines to tasks, round-robin, start from task 1

  if (comm_rank == 0) {
    char line[MAX_COMMAND_LEN + 2];
    int i = 0;
    MPI_Win_lock_all (MPI_MODE_NOCHECK, table);
    while (fgets (line, MAX_COMMAND_LEN + 2, stdin) != NULL) {
      if (i > MAX_COMMANDS * comm_size) {
        fprintf (stderr, "MAX_COMMANDS * comm_size (%d) exceeded.\n", i);
        MPI_Abort(MPI_COMM_WORLD, 1);
      }
      if (strlen (line) > MAX_COMMAND_LEN) {
        fprintf (stderr, "MAX_COMMAND_LEN exceeded, line %d: %s\n",
                 i, line);
        MPI_Abort(MPI_COMM_WORLD, 1);
      }
      MPI_Aint disp = (i / comm_size);
      int target_rank = (i + 1) % comm_size;
      MPI_Put (line, MAX_COMMAND_LEN, MPI_CHAR, target_rank, disp,
               MAX_COMMAND_LEN, MPI_CHAR, table);
      MPI_Win_flush_local (target_rank, table);
      i++;
    }
    MPI_Win_unlock_all (table);
  }

  MPI_Win_fence (0, table);

  // Execute command lines

  for (int i = 0; i < MAX_COMMANDS; i++) {
    if (strlen (commands[i]) < 1) break;
    system (commands[i]);
  }

  MPI_Win_free (&table);
  MPI_Barrier (MPI_COMM_WORLD);
  MPI_Finalize ();
  exit (EXIT_SUCCESS);
}
