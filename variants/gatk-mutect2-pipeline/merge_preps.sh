#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=samtools_merge
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:30:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required module
module load samtools

#reference file
PROJECT_ID='20-1LICH-001'
PREP1=$1
PREP2=$2 

mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam

# Merge preps into one bam file
samtools merge -X ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/${PREP1}_${PREP2}_merged.bam ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${PREP1}/${PREP1}_mdup_rg.bam ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${PREP2}/${PREP2}_mdup_rg.bam'
 
