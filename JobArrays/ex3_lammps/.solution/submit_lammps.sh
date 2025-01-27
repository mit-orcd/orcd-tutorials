#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -o log.lammps-%j
#SBATCH -n 4
#SBATCH --array=1-4

module load openmpi/4.1.4
module load lammps/20230802.3

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

# Specify Input Directory
INPUT_DIR=inputs/*
FILES=(${INPUT_DIR})

# Distribute files
MY_FILE_NUMS=( $(seq $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $NUM_FILES) )

# Iterate over $MY_FILE_NUMS
for IDX in "${MY_FILE_NUMS[@]}"; do

    # Get the $IDX-th file from $FILES
    INPUT_FILE="$(sed "${IDX}q;d" $FILES)"
    mpirun lmp -in $INPUT_FILE
done
