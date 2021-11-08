#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=samtools_concat
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=00:30:00
#SBATCH --mem=2G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required module
module load samtools

PROJECT_ID='20-1LICH-001'
CLONE_ID=$1
PREP1=$2
PREP2=$3 

#Retrieve sam header from one file

samtools view -H \
         /datastore/NGSF001/projects/20-1LICH-001/mutect2-pipeline/${PREP1}/${PREP1}_mdup_rg.bam \
         -o ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/sam_header.txt
         
# Merge preps into one bam file
samtools cat \
            -o ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/${CLONE_ID}_uninduced_concat.txt \
            -h ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/sam_header.txt \
            /datastore/NGSF001/projects/20-1LICH-001/mutect2-pipeline/${PREP1}/${PREP1}_mdup_rg.bam \
            /datastore/NGSF001/projects/20-1LICH-001/mutect2-pipeline/${PREP2}/${PREP2}_mdup_rg.bam

#index
samtools index ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/${PREP1}_${PREP2}_concat.bam
