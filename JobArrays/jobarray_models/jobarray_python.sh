#!/bin/bash

#SBATCH -o myjob.log-%A-%a
#SBATCH -a 0-3

# Load Anaconda Module
module load miniforge

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

python iterate_over_arr.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT