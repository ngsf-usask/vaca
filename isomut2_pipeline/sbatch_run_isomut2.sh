#!/bin/bash

#SBATCH --job-name=isomut2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1:30:00
#SBATCH --mem=6G

set -eux

module load gcc
module load python/3.8.10
module load scipy-stack/2021a
module load mpi4py/3.0.3
module load samtools/1.10
module load netcdf/4.7.4
export MKL_THREADING_LAYER=GNU
 
PATH=$HOME/venvs/isomut2py/bin/activate:$PATH
