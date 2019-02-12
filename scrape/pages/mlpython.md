## Mlpython

### Description

Mlpython are collections of python packages that facilitate the development of python scripts for GPU-enabled machine learning frameworks. They include GPU-optimized versions of the following python packages:

*   TensorFlow
*   Theano
*   Keras
*   PyTorch
*   MXNet
*   Horovod

The packages in the Mlpython environments are updated periodically.

The Mlpython modules are build on top of Taito-GPU's basic [python-env](https://research.csc.fi/-/python) modules. See that page for packages included in the basic modules and how to install your own packages.

If you think that some important ML package for python is missing or should be updated in the Mlpython modules, you can ask for installation from servicedesk@csc.fi.

Further remarks:

*   Different versions of TensorFlow can also be installed separately, see [the TensorFlow software page](https://research.csc.fi/-/tensorflow) for more information.
*   Caffe, Caffe2, and Dynet are also available as separate modules on Taito-GPU.
*   An alternative method of using machine learning frameworks with GPUs is to use the gpu flavors at [cPouta](https://research.csc.fi/pouta-user-guide). This is currently the recommended method for CNTK.
*   See further instructions on how to [use Jupyter notebooks on Taito-GPU](https://github.com/CSCfi/machine-learning-scripts/blob/master/notebooks/notebooks_on_taito-gpu.md)

* * *

### Available

##### Version on CSC's Servers

Taito-GPU:

*   python-env/2.7.10-ml
*   python-env/3.4.5-ml
*   python-env/3.5.3-ml
*   python-env/3.6.3-ml

Main components of available Mlpython modules:

 

python-env/2.7.10-ml

python-env/3.4.5-ml

python-env/3.5.3-ml

python-env/3.6.3-ml

CUDA

8.0

8.0

9.0

9.0

cuDNN

6.0

6.0

7.0

7.4.1

TensorFlow

1.9.0

1.9.0

1.11.0

1.12.0

Theano

1.0.1

1.0.1

1.0.1

 

Keras

2.2.2

2.2.2

2.2.4

2.2.4

PyTorch

0.3.0.post4

 

0.3.1

1.0.0

MXNet

1.2.0

 

1.3.1

 

Horovod

 

 

 

0.15.2

scikit-learn

0.19.0

0.19.1

0.19.1

0.19.1

OpenCV

 

 

3.4.1

3.4.1

* * *

### Usage

Mlpython can be used in Taito-GPU by loading a suitable python-env/_version_\-ml module:

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

Note that the Taito-GPU login node is not intended for heavy computing. Please use batch jobs instead. Assuming python-env/3.5.3-ml, here is a small example batch job script named "test-script.sh":

    #!/bin/bash
    #SBATCH -p gputest --gres=gpu:k80:1 --mem 8G -t 15
    srun python3.5 tensorflow-test.py

It can be submitted as:

    sbatch test-script.sh

Please see [https://research.csc.fi/taito-batch-jobs](https://research.csc.fi/taito-batch-jobs) for more information on the batch job system.

Note also that the login node does not have any GPU cards installed and importing Mlpython packages on the login node may therefore fail.

* * *

### Discipline

Mathematics and Statistics  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

* * *