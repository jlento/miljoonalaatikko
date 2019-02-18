# 6. Using Taito-GPU

This part of the guide gives a short introduction to compiling, running,
profiling and debugging applications that can utilize NVIDIA Tesla K80
and P100 GPUs installed on Taito.

GPGPU stands for *General-Purpose computation on Graphics Processing
Units*. GPUs can be used to accelerate computationally intensive code.
This is done together with CPUs by offloading some compute-intensive
parts of the application to the GPUs. GPGPU implementation is well
suited for data parallel and throughput intensive parts of the
application. Data parallelism in this case means that GPU can execute
the selected operation on different data elements simultaneously. GPUs
have thousands of cores for this task (NVIDIA Tesla P100 has 3584 cuda
cores). Also it is necessary to have lots of data otherwise the job is
not a throughput intensive.

## [6.1 Taito-GPU hardware and operating system]

## [6.2 Getting access to Taito-GPU]

## [6.3 Module and storage environment on Taito-GPU]

## [6.4 Compiling and linking GPU-programs]

## [6.5 Running GPU-programs]

## [6.6 Deploying GPU + MPI-programs]

## [6.7 Profiling GPU-programs]

## [6.8 Debugging GPU-programs]

## [6.9 Using Taito-GPU's graphics cards for rendering]

[6.9.1 TurboVNC installation][]  
[6.9.2 Opening VNC connection to Taito-GPU][]  
[6.9.3 Parameters of the script *gpu\_job\_reservation.sh*]

  [6.1 Taito-GPU hardware and operating system]: https://research.csc.fi/taito-gpu-hardware
  [6.2 Getting access to Taito-GPU]: https://research.csc.fi/taito-gpu-access
  [6.3 Module and storage environment on Taito-GPU]: https://research.csc.fi/taito-gpu-modules-and-storage
  [6.4 Compiling and linking GPU-programs]: https://research.csc.fi/taito-gpu-compiling
  [6.5 Running GPU-programs]: https://research.csc.fi/taito-gpu-running
  [6.6 Deploying GPU + MPI-programs]: https://research.csc.fi/taito-gpu-deploying
  [6.7 Profiling GPU-programs]: https://research.csc.fi/taito-gpu-profiling
  [6.8 Debugging GPU-programs]: https://research.csc.fi/taito-gpu-debugging
  [6.9 Using Taito-GPU's graphics cards for rendering]: https://research.csc.fi/taito-gpu-graphics
  [6.9.1 TurboVNC installation]: https://research.csc.fi/taito-gpu-graphics#6.9.1
  [6.9.2 Opening VNC connection to Taito-GPU]: https://research.csc.fi/taito-gpu-graphics#6.9.2
  [6.9.3 Parameters of the script *gpu\_job\_reservation.sh*]: https://research.csc.fi/taito-gpu-graphics#6.9.3
