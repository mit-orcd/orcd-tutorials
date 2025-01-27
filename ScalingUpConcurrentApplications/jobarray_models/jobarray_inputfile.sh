#!/bin/bash

# Scheduler Options
#SBATCH -p mit_normal
#SBATCH -o myout.log-%A-%a
#SBATCH -a 1-4

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT

# Specify Input File
INPUT_FILE=file.txt
NUM_LINES="$(wc -l < $INPUT_FILE)"

# Distribute line numbers
MY_LINE_NUMS=( $(seq $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $NUM_LINES) )

# Iterate over $MY_LINE_NUMS
for LINE_IDX in "${MY_LINE_NUMS[@]}"; do

    # Get the $LINE_IDX-th line from $INPUT_FILE
    INPUT="$(sed "${LINE_IDX}q;d" $INPUT_FILE)"

    # Run my_cmd on $INPUT
    my_cmd $INPUT
done