#!/bin/bash

# Scheduler Options
#SBATCH -p mit_normal
#SBATCH -o myout.log-%A-%a
#SBATCH -a 1-4

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

# Specify Input Directory
INPUT_DIR=inputs/*
FILES=(${INPUT_DIR})

# Distribute files
MY_FILE_NUMS=( $(seq $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $NUM_FILES) )

# Iterate over $MY_FILE_NUMS
for IDX in "${MY_FILE_NUMS[@]}"; do

    # Get the $IDX-th file from $INPUT_FILES
    INPUT_FILE="$(sed "${IDX}q;d" $INPUT_FILES)"

    # Run my_cmd on $INPUT_FILE
    my_cmd $INPUT_FILE
done