#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>

/*

  pexe

  pexe is a MPI program that reads command lines from stdin and distributes
  them to MPI tasks. Each MPI task runs it's command lines one by one with
  system() call.

  MPI implementation likely needs some encouragement to actually enable
  passive RMA (requires spinning extra threads, oversubscribes?). Setting

      export MPICH_ASYNC_PROGRESS=1

  seemed to do the trick.

  Build example:

      mpicc -o pexe -std=c11 -Wall -Wl,--as-needed pexe.c

  Usage example (tests work stealing):

      for ((i = 0; i < 23; i++)); do
          echo sleep $(( ((i+1)%3) * ((i+2)%3) ))'; echo "Rank ${SLURM_PROCID}, line '$i': $(date +%T)"'
      done | srun -p test -t 1 -n 3 pexe

*/

#define MAX_COMMANDS 10000  // ...per task
#define MAX_COMMAND_LEN 256

#ifdef NDEBUG
#define debug(...) ((void)0)
#else
#define debug(...) printf(__VA_ARGS__); fflush(stdout);
#endif

int main(int argc, char *argv[]) {
  MPI_Win counter, table;
  char commands[MAX_COMMANDS][MAX_COMMAND_LEN] = {0};
  int rank, comm_size, i;

  MPI_Init (&argc, &argv);

  MPI_Comm_rank (MPI_COMM_WORLD, &rank);
  MPI_Comm_size (MPI_COMM_WORLD, &comm_size);

  MPI_Win_create (&commands, MAX_COMMANDS * MAX_COMMAND_LEN, MAX_COMMAND_LEN,
                 MPI_INFO_NULL, MPI_COMM_WORLD, &table);

  MPI_Win_fence (0, table);

  // Distribute command lines to tasks, round-robin, start from task 1

  i = 0;
  if (rank == 0) {
    char line[MAX_COMMAND_LEN + 2];
    MPI_Win_lock_all (MPI_MODE_NOCHECK, table);
    while (fgets (line, MAX_COMMAND_LEN + 2, stdin) != NULL) {
      if (i >= MAX_COMMANDS * comm_size) {
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

  // Initialize next_command counter/pointer to the top of the command
  // line stack.

  int next_command;

  MPI_Win_create (&next_command, sizeof(int), sizeof(int),
                  MPI_INFO_NULL, MPI_COMM_WORLD, &counter);

  for (i = MAX_COMMANDS - 1; i >= 0; i--) {
    if (commands[i][0]) {
      next_command = i;
      break;
    }
  }

  MPI_Barrier (MPI_COMM_WORLD);

  // Execute command lines
  //
  // Process commands from own rank + steal_increment

  const int dec = -1;
  int steal_increment = 0;
  int current_command;
  while (steal_increment < comm_size) {
    int current_rank = (rank + steal_increment) % comm_size;
    MPI_Win_lock (MPI_LOCK_SHARED, current_rank, 0, counter);
    MPI_Fetch_and_op (&dec, &current_command, MPI_INT, current_rank,
                      0, MPI_SUM, counter);
    MPI_Win_unlock (current_rank, counter);
    if (current_command < 0) {
      steal_increment++;
    } else {
      char command[MAX_COMMAND_LEN] = {0};
      MPI_Win_lock (MPI_LOCK_SHARED, current_rank, MPI_MODE_NOCHECK, table);
      MPI_Get (&command, MAX_COMMAND_LEN, MPI_CHAR, current_rank,
               current_command, MAX_COMMAND_LEN, MPI_CHAR, table);
      MPI_Win_unlock (current_rank, table);
      system (command);
    }
  }

  MPI_Win_free (&counter);
  MPI_Win_free (&table);
  MPI_Barrier (MPI_COMM_WORLD);
  MPI_Finalize ();
  exit (0);
}
