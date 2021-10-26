#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=isomut2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load gcc/9.3.0
module load python/3.8.10
module load scipy-stack/2021a
module load mpi4py/3.0.3
module load samtools/1.10
module load netcdf/4.7.4
export MKL_THREADING_LAYER=GNU

source "$HOME/venvs/isomut2py/bin/activate"

PROJECT_ID='20-1LICH-001'
OUTDIR_NAME=$1
BAM_FILE=$2

#making project ID directory for storing results
mkdir -p ${HOME}/projects/${PROJECT_ID}/
mkdir -p ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}

# Run python script
#passing two arguments output directory path and bam file name
python $HOME/ngsf_git_repos/vaca/variants/isomut2_pipeline/isomut2_vaca_script.py ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME} ${BAM_FILE}
#python $HOME/ngsf_git_repos/vaca/variants/isomut2_pipeline/test.py ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME} ${BAM_FILE}
