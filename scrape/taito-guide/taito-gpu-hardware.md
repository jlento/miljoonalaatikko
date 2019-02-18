## 6.1 Taito-GPU hardware and operating system {#taito-gpu-hardware-and-operating-system style="text-align: justify;"}

The Taito cluster includes a separate partition of compute nodes with
dedicated GPU accelerator cards. Currently in the system there are 26
nodes containing 4 Pascal P100 GPUs each and 12 nodes with 2 dual GPU
K80 GPUs each.

  
The P100 nodes consists of 26 Dell PowerEdge C4130 servers with:

-   2x Xeon E5-2680 v4 CPUs with 14 cores each running at 2.4GHz
-   512 GB of DDR4 memory
-   4x P100 GPUs connected in pairs to each CPU
-   2x800GB of Sata SSD scratch space

  
The K80 nodes consists of 12 Dell PowerEdge C4130 servers with:

-   2x Xeon E5-2680 v3 CPUs with 12 cores each running at 2.5GHz
-   256 GB of DDR4 memory
-   2x K80 GPU cards each with 2 GPUs for a total of 4 GPUs per node,
    these are all connected to the first CPU
-   850GB of HDD scratch space

 

The different kinds of nodes are connected to each other using FDR
InfiniBand which is then connected to the Taito fabric allowing the use
of the same storage environment. Note that the P100 nodes can be moved
between Taito and the Pouta cloud environment meaning not all 26nodes
will be present all the time in Taito. The nodes share the same
operating system and offer a similar modules environment as the Taito
cluster, with the some of the modules in Taito-GPU being built and
optimized for GPU usage.
