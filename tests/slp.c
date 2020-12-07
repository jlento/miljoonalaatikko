//usr/bin/env mpicc -o ${0%.c} -fopenmp $0 && exec srun -N 1 -n 40 -t 10 --cpu-bind=verbose,none --export=ALL,OMP_NUM_THREADS=40 -A project_2002037 -p fmitest ${0%.c}

// GOAL: How to utilize the cores of idling tasks with OpenMP from task 0


#include <stdio.h>
#include <unistd.h>
#include <mpi.h>


// Number of terms in Gregory-Leibnitz approximation for Pi
// Use this to control the runtime

const size_t n = 100000000000ull;


void lazy_mpi_barrier(const unsigned int poll_interval) {

  // Lazy MPI barrier instead of busy looping normal MPI_Barrier
  // Allows other processes/threads to use the cores of the tasks that
  // are waiting at the barrier.

  MPI_Request request;
  int flag = 0;
  MPI_Ibarrier(MPI_COMM_WORLD, &request);
  while(!flag) {
    MPI_Test(&request, &flag, MPI_STATUS_IGNORE);
    sleep(poll_interval);
  }
}


long double Gregory_Leibnitz(size_t n){
  long double pi = 0;
#pragma omp parallel for shared(n) reduction(+:pi)
  for (size_t i = 1; i < n; i += 4) {
    pi += 4.0L / i - 4.0L / (i + 2);
  }
  return pi;
}


int main(int argc, char *argv[]) {
  int comm_rank;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &comm_rank);

  if (comm_rank == 0) {
    printf("The approximate value of Pi is %0.30Lf\n",
	   Gregory_Leibnitz(n));
  }

  lazy_mpi_barrier(1);

  MPI_Finalize();
  return 0;
}
