#!/bin/bash

#SBATCH -p mit_normal
#SBATCH -o log.lammps-%j
#SBATCH -n 4

module load openmpi/4.1.4
module load lammps/20230802.3

mpirun lmp -in in.heatflux
