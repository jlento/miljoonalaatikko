## TensorFlow

### Description

TensorFlow™ is an open source software library for numerical computation using data flow graphs. Nodes in the graph represent mathematical operations, while the graph edges represent the multidimensional data arrays (tensors) communicated between them. The flexible architecture allows you to deploy computation to one or more CPUs or GPUs in a desktop, server, or mobile device with a single API. TensorFlow was originally developed by researchers and engineers working on the Google Brain Team within Google's Machine Intelligence research organization for the purposes of conducting machine learning and deep neural networks research, but the system is general enough to be applicable in a wide variety of other domains as well.

GPU-enabled versions of TensorFlow for both Python 2 and Python 3 are available in Taito-GPU. For CPU-only TensorFlow, using an Intel-optimized version is recommended.

* * *

### Available

##### Version on CSC's Servers

Taito-GPU:

*   0.11\*
*   0.12.1
*   1.0.0\*
*   1.0.1\*
*   1.1.0\*
*   1.2.0\*
*   1.2.1
*   1.3.0
*   1.4.0
*   1.5.0
*   1.6.0
*   1.8.0 (Python 3.5 only)
*   1.9.0
*   1.11.0 (Python 3.5 only)
*   1.12.0 (Python 3.5 only)

The versions marked with an asterisk (\*) are optimized only for K80 GPUs.  The recent versions are optimized for both current CSC GPU types (K80 and P100).

* * *

### Usage

_These instructions are for installing a GPU-enabled version of TensorFlow in Taito-GPU. See below for installing a CPU-only version in Taito._

TensorFlow can be used either by installing a local version into $USERAPPL or by loading a generic [mlpython](https://research.csc.fi/-/mlpython) (machine learning) environment python-env/2.7.10-ml, python-env/3.4.5-ml, or python-env/3.5.3-ml. These two options are described below.

### 1) Installing TensorFlow into $USERAPPL

The following instructions install a recent CSC-compiled pip package of TensorFlow into $USERAPPL. Other versions can also be found at /appl/opt/tensorflow.

**Python 2**

Login to taito-gpu.csc.fi and run the following commands:

    module purge
    module load python-env/2.7.10 cuda/8.0.61 cudnn/6.0
    PYTHONUSERBASE=$USERAPPL/tensorflow.1.9.0 pip2.7 install --user /appl/opt/tensorflow/1.9.0/tensorflow-1.9.0-cp27-none-linux\_x86\_64.whl

Before running jobs, set up the environment like this:

    module purge
    module load python-env/2.7.10 cuda/8.0.61 cudnn/6.0
    export PYTHONPATH=$USERAPPL/tensorflow.1.9.0/lib/python2.7/site-packages

**Python 3.4**

Login to taito-gpu.csc.fi and run the following commands:

    module purge
    module load python-env/3.4.5 cuda/8.0.61 cudnn/6.0
    PYTHONUSERBASE=$USERAPPL/tensorflow.1.9.0-py34 pip3.4 install --user /appl/opt/tensorflow/1.9.0/tensorflow-1.9.0-cp34-cp34m-linux\_x86\_64.whl

Before running jobs, set up the environment like this:

    module purge
    module load python-env/3.4.5 cuda/8.0.61 cudnn/6.0
    export PYTHONPATH=$USERAPPL/tensorflow.1.9.0-py34/lib/python3.4/site-packages

**Python 3.5**

Login to taito-gpu.csc.fi and run the following commands:

    module purge
    module load python-env/3.5.3 cuda/9.0 cudnn/7.0-cuda9
    PYTHONUSERBASE=$USERAPPL/tensorflow.1.11.0-py35 pip3.5 install --user /appl/opt/tensorflow/1.11.0/tensorflow-1.11.0-cp35-cp35m-linux\_x86\_64.whl

Before running jobs, set up the environment like this:

    module purge
    module load python-env/3.5.3 cuda/9.0 cudnn/7.0-cuda9
    export PYTHONPATH=$USERAPPL/tensorflow.1.11.0-py35/lib/python3.5/site-packages

### 2) Using mlpython

The Python environments python-env/2.7.10-ml, python-env/3.4.5-ml, and python-env/3.5.3-ml contain up-to-date versions of several machine learning packages for Python, including TensorFlow, Theano, Keras, PyTorch, and MXNet. They can be loaded as:

    module purge
    module load python-env/2.7.10-ml

or

    module purge
    module load python-env/3.4.5-ml

or

    module purge
    module load python-env/3.5.3-ml

or

    module purge
    module load python-env/3.6.3-ml

Note that all ML packages are not available in all environments. See [Mlpython](https://research.csc.fi/-/mlpython) for more information. Also, note that the machine learning packages in the environments are updated periodically.

### Known issues

**MPI Error**

Slurm batch scripts running TensorFlow may encounter the following error message:

    python: error: \_get\_addr: No such file or directory
    Fatal error in PMPI\_Init\_thread: Other MPI error, error stack: 

This can be fixed by adding "srun" before the Python interpreter in the script.  For example:

    #!/bin/bash
    #SBATCH -p gputest --gres=gpu:k80:1 --mem 8G -t 15
    srun python2.7 my-tensorflow-program.py

### TensorBoard

To visualize TensorFlow computations using TensorBoard, a port on the local computer needs to be forwarded to taito-gpu.  Login to taito-gpu.csc.fi and launch TensorBoard as follows:

    ssh -l USERNAME -L PORT:localhost:PORT taito-gpu.csc.fi
        module purge
    module load python-env/3.4.5 cuda/8.0.61 cudnn/6.0
    export PYTHONPATH=$USERAPPL/tensorflow.1.9.0-py34/lib/python3.4/site-packages
    python3.4 -m tensorboard.main --logdir=LOGDIR --port=PORT
    

Replace USERNAME with your taito-gpu user name, PORT with a freely selectable port number (>1023),  and LOGDIR with the name of the directory containing TensorFlow event files. By default, TensorBoard uses the port 6006, but using a different port is recommended to avoid overlaps. (Python 3.4 and TensorFlow 1.9.0 are assumed in this example.)

To access TensorBoard, point your web browser to _localhost:_PORT .

### Keras

Keras is a high-level neural networks API capable of running on top of TensorFlow (among other frameworks).  It can be installed using pip.

**Python 2**

pip install --user keras

**Python 3**

pip3 install --user keras

### Installing CPU-only TensorFlow in Taito

Using an [Intel-optimized version](https://software.intel.com/en-us/articles/intel-optimized-tensorflow-wheel-now-available) is recommended for CPU-only usage of TensorFlow.

**Python 2**

Login to taito.csc.fi and run the following commands:

    module purge
    module load python-env/2.7.10
    pip install --user https://anaconda.org/intel/tensorflow/1.4.0/download/tensorflow-1.4.0-cp27-cp27mu-linux\_x86\_64.whl

Before running jobs, set up the environment e.g. like this:

    module purge
    module load python-env/2.7.10
    export KMP\_BLOCKTIME=0
    export KMP\_AFFINITY=granularity=fine,verbose,compact,1,0
    export KMP\_SETTINGS=1
    export OMP\_NUM\_THREADS=24

See the [TensorFlow Performance guide](https://www.tensorflow.org/performance/performance_guide) for more information. Using the [Haswell nodes at Taito](https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.4) is recommended.

* * *

### Discipline

Mathematics and Statistics  

* * *

### References

[https://www.tensorflow.org](https://www.tensorflow.org)

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

Please see the TensorFlow documentation at [https://www.tensorflow.org/](https://www.tensorflow.org/) .

* * *