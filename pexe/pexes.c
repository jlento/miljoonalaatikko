#define _GNU_SOURCE
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*

  pexes

  pexes is a tool for running short independent single core calculations in
  parallel.

  Build example:

      mpicc -o pexes -std=c11 -Wall -Wl,--as-needed pexes.c

  Usage example (puhti.csc.fi):

      sbatch test.sh

      where 'test.sh' is

      #!/bin/bash
      #SBATCH --account=<your account here>
      #SBATCH --partition=test
      #SBATCH --time=1
      #SBATCH --ntasks=3
      for ((i = 0; i < 23; i++)); do
          echo "sleep $(( ((i+1)%3) * ((i+2)%3) ))"
      done | srun -n 4 -O pexes

  NOTE: The number of MPI tasks launched by mpirun can be one more than the
  number of cores reserved. See the usage example above.

*/


#define MAX_COMMAND_LEN 1024
#define RANK_MASTER 0

#ifdef NDEBUG
#define debug(...) ((void)0)
#else
#define debug(...)                                                         \
    printf (__VA_ARGS__);                                                  \
    fflush (stdout)
#endif
#define info debug

int main (int argc, char *argv[])
{
    int  rank;
    char command[MAX_COMMAND_LEN] = {0};

    MPI_Init (&argc, &argv);
    MPI_Comm_rank (MPI_COMM_WORLD, &rank);

    if (rank == RANK_MASTER)

        /* Master task
         *
         * Loop 1, dispatch commands:
         * - read a command from stdin
         * - wait for a command request from a slave
         * - send the command to the slave
         * - exit loop when no more lines in the stdin
         *
         * Loop 2, dispatch completion signals:
         * - wait for a command request from a slave
         * - send an empty command to the slave
         * - exit loop after responding to all slave tasks (NTASKS - 1)
         */
    {
        int slaveid;
        while (fgets (command, MAX_COMMAND_LEN, stdin) != NULL)
        {
            if (strlen (command) < 1)
                continue;
            if (strlen (command) > MAX_COMMAND_LEN - 1)
            {
                fprintf (stderr, "MAX_COMMAND_LEN exceeded, command: %s\n",
                         command);
                MPI_Abort (MPI_COMM_WORLD, 1);
            }
            MPI_Recv (&slaveid, 1, MPI_INT, MPI_ANY_SOURCE, 0,
                      MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            MPI_Send (&command, MAX_COMMAND_LEN, MPI_CHAR, slaveid, 0,
                      MPI_COMM_WORLD);
        }
        int size;
        MPI_Comm_size (MPI_COMM_WORLD, &size);
        bzero (command, MAX_COMMAND_LEN);
        for (int i = 0; i < size - 1; i++)
        {
            MPI_Recv (&slaveid, 1, MPI_INT, MPI_ANY_SOURCE, 0,
                      MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            MPI_Send (&command, MAX_COMMAND_LEN, MPI_CHAR, slaveid, 0,
                      MPI_COMM_WORLD);
        }
    }

    else

    /* Slave task
     *
     * Loop:
     * - request a command from the master and run it
     * - exit loop when receiving the empty command
     */

    {
        for (;;)
        {
            MPI_Send (&rank, 1, MPI_INT, RANK_MASTER, 0, MPI_COMM_WORLD);
            MPI_Recv (&command, MAX_COMMAND_LEN, MPI_CHAR, RANK_MASTER, 0,
                      MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            if (strlen (command) > 0)
            {
                time_t now;
                time (&now);
                struct tm *t = localtime (&now);
                info ("[Rank %d, %02d:%02d:%02d]$ %s", rank, t->tm_hour,
                      t->tm_min, t->tm_sec, command);
                system (command);
            }
            else
            {
                break;
            }
        }
    }
    info ("Rank %d closing.\n", rank);
    MPI_Finalize ();
    return 0;
}
