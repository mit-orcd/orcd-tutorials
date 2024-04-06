#!/bin/bash

#SBATCH -p sched_mit_orcd
#SBATCH -o mnist_timed.out-%j

source .venv/bin/activate

python -u mnist_timed.py --epochs=5
