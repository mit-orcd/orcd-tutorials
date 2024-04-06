#!/bin/bash

#SBATCH -p sched_mit_orcd
#SBATCH -o log.mnist-%j

module load lammps/20220623-x86_64

mpirun lmp -in in.heatflux
