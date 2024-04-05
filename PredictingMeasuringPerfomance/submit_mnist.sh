#!/bin/bash

#SBATCH -p sched_mit_orcd
##SBATCH --exclusive

source .venv/bin/activate

python -u mnist.py --epochs=1
