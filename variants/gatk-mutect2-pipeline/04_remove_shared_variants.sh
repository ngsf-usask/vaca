#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=bcftools
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2:00:00
#SBATCH --mem=4G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module spider bcftools/1.13

#reference file
REF='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'
PROJECT_ID='20-1LICH-001'
INPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/mutect2_calling"
INDUCED_VCF=$1
UNINDUCED_VCF=$2
mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/
OUTPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/"

bcftools -C -c none -O z -o ${OUTPUT_DIR}${INDUCED_VCF}_${UNINDUCED_VCF} ${INDUCED_VCF} ${UNINDUCED_VCF}
