#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=bcftools
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=30:00:00
#SBATCH --mem=4G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load StdEnv/2020
module load gcc/9.3.0
module spider bcftools/1.13

PROJECT_ID='20-1LICH-001'
INPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/mutect2_calling"
CLONE_ID=$1
INDUCED_VCF=$2
UNINDUCED_VCF=$3

mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/
OUTPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/"

bcftools isec -C -c none -O z -o ${OUTPUT_DIR}${CLONE_ID}_${INDUCED_VCF}_${UNINDUCED_VCF}.vcf.gz ${INPUT_DIR}${INDUCED_VCF}.vcf.gz ${INPUT_DIR}${CLONE_ID}_${UNINDUCED_VCF}.vcf.gz


