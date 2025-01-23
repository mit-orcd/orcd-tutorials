#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -c 1
#SBATCH -o log.mnist-%j

# Set number of cores
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Load the miniforge python module
module load miniforge

# Run the example
python -u mnist.py
