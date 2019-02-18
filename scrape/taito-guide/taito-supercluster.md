# 1.1 Taito supercluster {#taito-supercluster align="JUSTIFY"}

## [][1]1.1.1 User policy

The Taito supercluster (taito.csc.fi) is intended for serial and medium
sized parallel tasks as well as jobs that require a lot of memory.
Researchers that want to use Taito should 1) **register as CSC users**
and then 2) **apply for a computing project**. This registration process
is described in the chapters [1.2.1] and [1.2.2.2] of the CSC computing
environment user guide.  
  
A computing project at CSC has a common computing quota that can be
extended by application. Use of Taito or any other server will consume
the computing quota granted to the project. **One core hour in Taito
consumes 2 billing units** from the computing quota of the project.

The Taito users are allowed to submit up to 1024 simultaneous batch jobs
to be executed. The maximum size of a single job is at most 448 compute
cores usin*g* 672 CPUs.

**Table 1.1** Available batch jobs queues in supercluster taito.csc.fi.

|                  |                               |                      |
|------------------|-------------------------------|----------------------|
| **Queue**        | **Number of cores**           | **Maximum run time** |
| serial (default) | 24 (one node)                 | 3 days               |
| parallel         | 672 (28 nodes)                | 3 days               |
| longrun          | 24 (one node)                 | 14 days              |
| test             | 32  / 48 (two nodes)          | 30 min               |
| hugemem          | 40 (one haswell hugemem node) | 7 days/14days        |

 

In Taito you don't need to sent the scaling test results of your
parallel code to CSC. However, you should still make sure that you are
using the resources efficiently i.e. that your code - with the used
input - does scale to the selected number of cores. The rule of thumb is
that when you double the number of cores, the job should to run at least
1.5 times faster. If it doesn't, you should use less cores. Note that
scaling depends on the input (model system) as well as the used code, so
you may need to test separately for scaling with the same code for
different model systems. If you are unsure, contact [CSC Service Desk].

## [][2]1.1.2 Hardware

Taito (taito.csc.fi) is a 16 cabinet HP cluster based on commodity
off-the-shelf building blocks. The theoretical peak performance of the
cluster, calculated on the aggregate performance of the computing nodes,
is about 600 TFlop/s. 

#### **Sandy bridge nodes** {#sandy-bridge-nodes align="JUSTIFY"}

As a preparation for the installallation of the new cluster environment,
the older part of Taito, consisting of 576 Sandy Bridge nodes, was
removed in January 2019.

#### Haswell nodes {#haswell-nodes align="JUSTIFY"}

The *Haswell* processors comprise several components: twelve cores with
individual L1 and L2 caches, an integrated memory controller, three QPI
links, and an L3 cache shared within the socket. The processor supports
several instructions sets, most notably the *Advanced Vector Extensions
2* (AVX2) instruction set; however, older instructions sets are still
supported. Each Haswell core has dedicated 32KB of L1 cache, and 768 KB
of L2 cache. The L3 cache is shared among the processors, and its size
is 30 MB. Most of the Haswell nodes (397) have 8 slots of 16GB DDR4
DIMMs, operating at 2133 MHz, for a total of 128GB per compute node.
This means that there are 5,3 GB of memory available per core. There are
also ten Haswell-equipped nodes with 16 modules of 16 GB 2133 MHz DIMMs,
that is  256 GB of DDR4 memory per node, and 10,7 GB per core.

#### Hugemem nodes {#hugemem-nodes align="JUSTIFY"}

For jobs requiring very large memory, Taito includes six *hugemem* nodes
each having **1,5 TB** of memory:

-   two HP Proliant DL560 nodes, with 2.7Ghz Sandy Bridge processors 
    with 32 cores (four eight node sockets) and 2 TB of  local temporary
    storage space.
-   four Dell R930 nodes, with 2.8Ghz Haswell processors  with 40 cores 
    and 2,6 TB of  local SSD based fast temporary storage space.

 

#### Login nodes {#login-nodes align="JUSTIFY"}

In addition to the computing nodes, Taito has four login nodes, two of
which (taito-login3 and taito-login4) are used for logging into the
system, submitting jobs, I/O and service usage. The tow other login
nodes act as the front ends for the GPGPU and MIC hardware linked to the
cluster.  The login nodes are HP Proliant DL380 G8.

#### Interconnect {#interconnect align="JUSTIFY"}

Communication among nodes and to the storage is done by Infiniband FDR
fabric, which provides low latency and high throughput connectivity.
High speed interconnect is provided by 58 Mellanox Infiniband FDR
switches with 36 ports each, and by the Infiniband HCAs installed on
each computing node. The network topology for the cluster is 4:1 pruned
tree fabric.

**Table 1.2** Configuration of the Taito.csc.fi supercluster. The
aggregate performance of the system is 600 TF/s.

<table style="width:100%;">
<colgroup>
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 16%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Node type</strong></th>
<th style="text-align: right;"><strong>Number of nodes</strong></th>
<th style="text-align: right;"><strong>Node model</strong></th>
<th style="text-align: right;"><strong>Number of cores / node</strong></th>
<th style="text-align: right;"><strong>Total number of cores</strong></th>
<th style="text-align: right;"><strong>Memory / node</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Sandy Bridge login node</p></td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">HP Proliant DL380 G8</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">64</td>
<td style="text-align: right;">64 / 192 GB</td>
</tr>
<tr class="even">
<td>Haswell compute node</td>
<td style="text-align: right;">397</td>
<td style="text-align: right;">HP Apollo 6000 XL230a G9</td>
<td style="text-align: right;">24</td>
<td style="text-align: right;">9528</td>
<td style="text-align: right;">128 GB</td>
</tr>
<tr class="odd">
<td>Haswell big memory node</td>
<td style="text-align: right;">10</td>
<td style="text-align: right;">HP Apollo 6000 XL230a G9</td>
<td style="text-align: right;">24</td>
<td style="text-align: right;">240</td>
<td style="text-align: right;">256 GB</td>
</tr>
<tr class="even">
<td>Sandy Bridge big memory node (these nodes has been removed)</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">HP SL230s G8</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">256</td>
<td style="text-align: right;">256 GB</td>
</tr>
<tr class="odd">
<td>Sandy Bridge huge memory node</td>
<td style="text-align: right;">2</td>
<td style="text-align: right;">HP Proliant DL560 </td>
<td style="text-align: right;">32</td>
<td style="text-align: right;">64</td>
<td style="text-align: right;">1,5 TB</td>
</tr>
<tr class="even">
<td>Haswell huge memory node</td>
<td style="text-align: right;">4</td>
<td style="text-align: right;">Dell R930</td>
<td style="text-align: right;">40</td>
<td style="text-align: right;">160</td>
<td style="text-align: right;">1,5 TB</td>
</tr>
</tbody>
</table>

The following commands can give some useful information from the whole
Taito system or from the current node a user is logged in.

To get a quick overview of all Taito compute node status use the
following command:

    sinfo -Nel

The above command prints information in a compute node oriented format.
Alternatively, you can get the information in in a partition/queue
oriented format with command:

    sinfo -el 

For information about the disk systems one can use the following
command:

    df -h

Details about the available processors on the current node can be
checked with:

    cat /proc/cpuinfo

And details about the current memory usage on the node is shown with:

`cat /proc/meminfo`

 

 

  [1]: https://research.csc.fi/ {#1.1.1}
  [1.2.1]: https://research.csc.fi/csc-guide-getting-access-to-cscs-resources#1.2.1
  [1.2.2.2]: https://research.csc.fi/csc-guide-getting-access-to-cscs-resources#1.2.2.1
  [CSC Service Desk]: https://research.csc.fi/support
  [2]: https://research.csc.fi/ {#1.1.2}
