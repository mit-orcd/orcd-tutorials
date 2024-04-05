#!/bin/bash

#SBATCH -p sched_mit_orcd
##SBATCH --exclusive

source .venv/bin/activate

python -u mnist_timed.py --epochs=5
