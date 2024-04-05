
# Predicting and Measuring Performance

This directory contains two examples for examining serial code and doing a basic parallel scaling analysis. The "main.py" example trains an MNIST model.

## Start an interactive job

Start an interactive job on a full exclusive node:

LLsub -i full

If the system is busy you may have to wait for a node to become available. Since we'll be doing some profiling it will be important that nothing else is running on the node so we can get accurate numbers. Open a second terminal and ssh to the node where the interactive job is running. Remember to exit out of both of these tereminal sessions when you are done.

## Let's look at htop

In the terminal that you have ssh'd to the node with the interactive job, run the "htop" command. Familiarize yourself with the different outputs. These are listed in the Practical HPC course.

In the terminal with the interactive job, load the anaconda/2022b module and run:

python main.py

Look at the terminal where you have htop running. How many threads is it using?

## Set number of threads

To get a good idea of serial performance we need to tell PyTorch to only use one thread. We can do this by setting the OMP_NUM_THREADS environment variable. Go to the interactive job terminal and set:

export OMP_NUM_THREADS=1

Now run the code again and check htop. Is it only using one thread now?

## Time the serial code

Now that we are sure we have our code running serially, we can time it. This is done in the main_timed.py script. Run:

python main.py --epochs=1

to completion. Note the total training time.

## Analyze the serial performance

We have serial time. We might want to time different portions of the code to see if there are any bottlenecks we can improve. We also want to know what the memory footprint is for the job, which we can get after the job completes with the sacct command:

sacct -j JOBID -o JobID,AllocCPUS,MaxRSS --units=G

We want to ask ourselves: how can we scale? Is there a parallel implementation? Is it shared or distributed memory? Can we make use of accelerators? In this case, PyTorch can use shared memory parallelism through multithreading, and can make use of GPUs. To see what resources would be ideal for this job we can do a quick scaling experiment.

## Quick Scaling Experiment

We already have the serial run time, so set OMP_NUM_THREADS to 2 and run the code:

export OMP_NUM_THREADS=2
python main_timed.py

And record the time. Repeat for 4, 8, 16, 32, and 48 (the total number of cores on the cpu nodes).

Parallel speedup can be calculated by dividing the serial time by the parallel time (T_serial/T_parallel). You can then plot this to get the speedup plot, and you can see what number will give you the best speedup.

You can repeat the same experiment with a GPU. Request an exclusive GPU node and set OMP_NUM_THREADS to the number that gave the best speedup in the previous exercise. Then run the code and calculate the speedup in relation to what you got with the pure CPU threading example (T_cpu/T_gpu). What is the speedup you get? Is it worth adding the GPU in this case (with GPUs we are looking for >10x speedup)? Why or why not? Why might the speedup with the GPU be limited?

