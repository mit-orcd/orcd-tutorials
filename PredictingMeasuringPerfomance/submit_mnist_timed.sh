#!/bin/bash

#SBATCH -p sched_mit_orcd
#SBATCH -o log.mnist_timed-%j

source .venv/bin/activate

python -u mnist_timed.py --epochs=5
