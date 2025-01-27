#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -o jobarray.out-%A-%a
#SBATCH --array=1-4

echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_TASK_COUNT: " $SLURM_ARRAY_TASK_COUNT

sleep 10