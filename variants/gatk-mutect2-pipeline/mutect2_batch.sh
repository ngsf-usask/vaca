#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=gatk-mutect2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=1:00:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load gatk/4.2.2.0

#reference file
REF ='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'

PROJECT_ID='20-1LICH-001'
OUTDIR_NAME=$1
BAM_FILE=$2

#making project ID directory for storing results
mkdir -p ${HOME}/projects/${PROJECT_ID}/
mkdir -p ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}

#Run Mutect2
gatk Mutect2 -R ${REF} -I ${BAM_FILE} -O ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}/unfiltered.vcf && gatk FilterMutectCalls -R ${REF} -V ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}/unfiltered.vcf -O ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}/filtered.vcf

#https://gatk.broadinstitute.org/hc/en-us/articles/360035531132--How-to-Call-somatic-mutations-using-GATK4-Mutect2
