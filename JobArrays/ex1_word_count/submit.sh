#!/bin/bash

#SBATCH -o submit_each.sh.log-%j
#SBATCH -p mit_normal

# Load Anaconda Module
module load miniforge

# Call your script as you would from the command line
python top5each.py
