#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -o log.mnist-%A-%a
#SBATCH --array=0-3

# Load the miniforge python module
module load miniforge

# Specify Input File
INPUT_FILE=inputs.txt
NUM_LINES="$(wc -l < $INPUT_FILE)"

# Distribute line numbers
MY_LINE_NUMS=( $(seq $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT $NUM_LINES) )

# Iterate over $MY_LINE_NUMS
for LINE_IDX in "${MY_LINE_NUMS[@]}"; do

    # Get the $LINE_IDX-th line from $INPUT_FILE
    INPUT="$(sed "${LINE_IDX}q;d" $INPUT_FILE)"

    echo "Running with hyperparameters: " $INPUT

    # Run the example
    python -u mnist.py $INPUT
done
