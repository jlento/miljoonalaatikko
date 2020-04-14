//usr/bin/env mpicc -o ${0%.c} -fopenmp $0 && exec srun -n 4 -t 10 --cpu-bind=verbose,none --export=ALL,OMP_NUM_THREADS=4 -A project_2002037 -p fmitest ${0%.c}

#include <stdio.h>
#include <unistd.h>
#include <mpi.h>

// Number of terms in Gregory-Leibnitz approximation for Pi

// Runs long enough to have a good look with 'top'
// size_t n = 1000000000000ull;

// Runs under 2 min (single core/thread) for multiple-thread speedup testing
size_t n = 100000000000ull;


int main(int argc, char *argv[]) {
  int comm_size, comm_rank;
  MPI_Request request;
  int flag = 0;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_size);
  MPI_Comm_rank(MPI_COMM_WORLD, &comm_rank);
  if (comm_rank == 0) {
    long double pi = 0;
#pragma omp parallel for shared(n) reduction(+:pi)
    for (size_t i = 1; i < n; i += 4) {
      pi += 4.0L / i - 4.0L / (i + 2);
    }
    printf("The value of Pi is %0.30Lf\n", pi);
  }
  MPI_Ibarrier(MPI_COMM_WORLD, &request);
  while(!flag) {
    MPI_Test(&request, &flag, MPI_STATUS_IGNORE);
    sleep(1);
  }
  printf("Task %d done!\n", comm_rank);
  MPI_Finalize();
  return 0;
}
