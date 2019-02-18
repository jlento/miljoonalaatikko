# 6.7 Profiling GPU-programs

## [][1]6.7.1 Introduction

In order to monitor performance of your GPU application, the best bet is
to use NVIDIA's "nvprof" command line tool.  
It shows you how much time is spent in CUDA-kernels and data transfers
between host CPU and GPU. It does not show performance of the host part
of your application.

## [][2]6.7.2 Using nvprof

The nvprof is unbelievably easy to use. You don't have to recompile nor
relink your application. Only put "nvprof" in front of your application
invokation and you are done. Profiling output will be written in a human
readable form immediately after completion of your application.

------------------------------------------------------------------------

The CUDA-only application gives the following output :

    srun -N1 -pgpu --gres=gpu:k40:1 nvprof daxpy.x.gnu
    ==117693== NVPROF is profiling process 117693, command: daxpy.x.gnu
    n=134217728 : vlen=256 : griddim = 524288 1 1 : blockdim.x = 256 1 1
    daxpy(n=134217728): sum=9.0072e+15 : check_sum=9.0072e+15 : diff=0
    ==117693== Profiling application: daxpy.x.gnu
    ==117693== Profiling result:
    Time(%)      Time     Calls       Avg       Min       Max  Name
     78.52%  1.35003s         2  675.01ms  668.75ms  681.27ms  [CUDA memcpy HtoD]
     20.49%  352.28ms         1  352.28ms  352.28ms  352.28ms  [CUDA memcpy DtoH]
      0.99%  16.967ms         1  16.967ms  16.967ms  16.967ms  daxpy(int, double, double const *, double*)

    ==117693== API calls:
    Time(%)      Time     Calls       Avg       Min       Max  Name
     87.15%  1.72141s         3  573.80ms  369.60ms  682.45ms  cudaMemcpy
     12.73%  251.40ms         2  125.70ms  1.2711ms  250.12ms  cudaMalloc
      0.09%  1.8257ms         2  912.83us  839.03us  986.63us  cudaFree
      0.02%  311.92us        83  3.7580us     269ns  126.07us  cuDeviceGetAttribute
      0.00%  68.179us         1  68.179us  68.179us  68.179us  cudaLaunch
      0.00%  47.282us         1  47.282us  47.282us  47.282us  cuDeviceTotalMem
      0.00%  39.486us         1  39.486us  39.486us  39.486us  cuDeviceGetName
      0.00%  13.732us         4  3.4330us     237ns  11.644us  cudaSetupArgument
      0.00%  3.2010us         1  3.2010us  3.2010us  3.2010us  cudaConfigureCall
      0.00%  2.8320us         2  1.4160us     505ns  2.3270us  cuDeviceGetCount
      0.00%  1.1070us         2     553ns     505ns     602ns  cuDeviceGet

------------------------------------------------------------------------

Whereas running OpenACC C-version of DAXPY against "nvprof" gives :

    % srun -N1 -pgpu --gres=gpu:k40:1 nvprof daxpy.x.acc
    ==115197== NVPROF is profiling process 115197, command: daxpy.x.acc
    daxpy(n=134217728): sum=9.0072e+15 : check_sum=9.0072e+15 : diff=0
    ==115197== Profiling application: daxpy.x.acc
    ==115197== Profiling result:
    Time(%)      Time     Calls       Avg       Min       Max  Name
     50.68%  18.245ms         1  18.245ms  18.245ms  18.245ms  daxpy_27_gpu
     31.15%  11.213ms         1  11.213ms  11.213ms  11.213ms  init_13_gpu
     17.81%  6.4099ms         1  6.4099ms  6.4099ms  6.4099ms  sum_up_35_gpu
      0.35%  127.00us         1  127.00us  127.00us  127.00us  sum_up_36_gpu_red
      0.01%  3.0080us         1  3.0080us  3.0080us  3.0080us  [CUDA memcpy DtoH]
      0.00%  1.5990us         1  1.5990us  1.5990us  1.5990us  [CUDA memcpy HtoD]

    ==115197== API calls:
    Time(%)      Time     Calls       Avg       Min       Max  Name
     86.57%  272.72ms         1  272.72ms  272.72ms  272.72ms  cuCtxCreate
     11.44%  36.034ms         8  4.5042ms  1.7240us  18.252ms  cuStreamSynchronize
      1.35%  4.2681ms         5  853.63us  147.42us  2.0846ms  cuMemAlloc
      0.36%  1.1258ms         1  1.1258ms  1.1258ms  1.1258ms  cuMemAllocHost
      0.18%  571.83us         1  571.83us  571.83us  571.83us  cuModuleLoadData
      0.06%  193.58us         4  48.394us  20.160us  125.87us  cuLaunchKernel
      0.02%  52.670us         1  52.670us  52.670us  52.670us  cuStreamCreate
      0.01%  29.421us         1  29.421us  29.421us  29.421us  cuMemcpyDtoHAsync
      0.01%  19.862us         1  19.862us  19.862us  19.862us  cuMemcpyHtoDAsync
      0.00%  13.031us        14     930ns     373ns  2.5170us  cuPointerGetAttribute
      0.00%  2.7230us         4     680ns     330ns  1.6490us  cuModuleGetFunction
      0.00%  2.6310us         2  1.3150us     431ns  2.2000us  cuDeviceGetCount
      0.00%  2.0510us         1  2.0510us  2.0510us  2.0510us  cuCtxAttach
      0.00%  1.8740us         1  1.8740us  1.8740us  1.8740us  cuCtxSetCurrent
      0.00%  1.1190us         2     559ns     555ns     564ns  cuDeviceGet
      0.00%  1.0990us         2     549ns     297ns     802ns  cuCtxGetCurrent
      0.00%     815ns         1     815ns     815ns     815ns  cuDeviceComputeCapability

  [1]: https://research.csc.fi/ {#6.7.1}
  [2]: https://research.csc.fi/ {#6.7.2}
