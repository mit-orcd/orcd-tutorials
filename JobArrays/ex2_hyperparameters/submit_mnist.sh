#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -o log.mnist-%j

# Load the miniforge python module
module load miniforge

# Run the example
python -u mnist.py --lr=0.05 --batch-size=64
