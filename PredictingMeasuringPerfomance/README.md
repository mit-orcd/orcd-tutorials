
# Predicting and Measuring Performance

This directory contains two examples for examining serial code and doing a basic parallel scaling analysis. The "mnist.py" example trains an MNIST model.

## Setup

A `setup.sh` script is provided to create a Python virtual environment and then download the small MNIST dataset. The virtual environment is defined in the `requirements.txt` file, the main dependencies for the example are `torch` and `torchvision`. The example should work with any version.

The `setup.sh` script loads the default Python module, you can edit the script to use your favorite Python or Anaconda module.

Run the `setup.sh` script on a compute node in the partition you intend to run the example in. To do that submit `setup.sh` as a job in your target partition:

```bash
sbatch -p PARTITION setup.sh
```

where `PARTITION` is your target partition.

## Examine the Example Code

Look at the example.

Discuss: Is the example multithreaded? Distributed? Does it use a GPU? Do you think it has any memory requirements? What is your first guess at what resources to select for the job?

## Run the Example

Run the example as a job requesting the resources you just discussed. Use a small numbers (of cores, for example), but enough to confirm you are getting what you are asking for.

Check that your job was allocated the resources you requested. For running jobs you can use the `squeue` command with some additional flags:

```bash
squeue --me -O JobArrayID,NumNodes,NumCPUs,tres-per-node,MinMemory,State,ReasonList
```

For completed jobs use the `sacct` command:

```bash
sacct -j JOBID -o JobID,JobName,Partition,AllocCPUS,AllocNodes,ReqMem,State
```

where `JOBID` is the Job ID for your job.

Completed GPU jobs, you can add the following to your job script, which will print the GPU ID to the job's log file:

echo $CUDA_VISIBLE_DEVICES

## Evaluate the Running Code

Run your job and take node of the node it is running on. If you are running your own code pick a case that runs for a few minutes.

In a separate terminal or tab ssh to the node where your job is running and start `htop -u USERNAME` or `top -u USERNAME` (where `USERNAME` is your Engaging username). Watch the output while your job runs.

Watch the memory utilization, CPU load, and the processes/threads that appear at the bottom. Is this what you expect?

Stop the job (`scancel JOBID`, where `JOBID` is the Job ID for your job) and check the peak memory utilization with sacct - is this what you expected based on what you saw in htop?

## Time the Code

Add in time measurements for the code and print them out. You can use the “mnist_timed.py” script where this is already done for you if you need to save time.

Get an overall Serial time for the code and note it down. If you are using your own example and it is large use a smaller example, or part of the example. Or, if the mnist example is taking too long on the node you are using you can reduce the number of epochs in the job script.

If you have time, time different portions of your code and find what takes the most time. Are there any bottlenecks? Are they what you expected? Think about what changes you could make to your code to improve these. Note that hou may not be able to do this for a precompiled code that you did not write.

## Calculate Speedup and Make a Speedup Curve

You have your serial time number from the previous step, add processors/accelerators and calculate speedup. Most of us use existing codes and packages that use one of the following:

- Shared memory: Create a speedup curve increasing number of threads 2,4,8,16,32 (continue with powers of 2 until you reach the total number of cores on the node you are using)
- Distributed memory: Create a speedup curve increasing number of processes 2,4,8,16,32, etc. Note you will often see a difference depending on whether all processes are on the same node or not.
- GPUs: Many of these also support shared memory, first start up scaling up with cpus using # of thread as described for Shared memory. Then run it with a GPU. What speedup do you see with the GPU vs with CPUs? Is it worth using the GPU?