#!/bin/bash

#SBATCH -p sched_mit_orcd
#SBATCH -o mnist.out-%j

# Activate the environment you set this up for
source .venv/bin/activate

# Run the example
python -u mnist.py --epochs=5
