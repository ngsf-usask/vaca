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
module load StdEnv/2020
module load gcc/9.3.0
module spider bcftools/1.13

PROJECT_ID='20-1LICH-001'
INPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/mutect2_calling"
INDUCED_VCF=$1
UNINDUCED_VCF=$2
mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/
OUTPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/"

bcftools isec -C -c none -O z -o ${OUTPUT_DIR}${INDUCED_VCF}_${UNINDUCED_VCF} ${INDUCED_VCF} ${UNINDUCED_VCF}

bcftools merge --force-samples ${HOME}/projects/20-1LICH-001/mutect2-pipeline/mutect2_calling/D2100004_E2100016.vcf.gz ${HOME}/projects/20-1LICH-001/mutect2-pipeline/mutect2_calling/D2100009_E2100021.vcf.gz -o ${HOME}/projects/20-1LICH-001/mutect2-pipeline/filtered_vcfs/uninduced.vcf.gz -O z
bcftools index -t ${HOME}/projects/20-1LICH-001/mutect2-pipeline/filtered_vcfs/uninduced.vcf.gz
bcftools isec -C -c none -o ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/filtered_vcfs/induced.vcf.gz ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/mutect2_calling/D2100006_E2100018.vcf.gz ${HOME}/projects/20-1LICH-001/mutect2-pipeline/filtered_vcfs/uninduced.vcf.gz -O z

