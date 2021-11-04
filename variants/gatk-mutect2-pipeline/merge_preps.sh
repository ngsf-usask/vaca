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
samtools merge -X mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/${PREP1}_${PREP2}_merged.bam ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${PREP1}/${PREP1}_mdup_rg.bam ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${PREP2}/${PREP2}_mdup_rg.bam

D2100001	E2100013
D2100002	E2100014
D2100003	E2100015
D2100004	E2100016
D2100005	E2100017
D2100006	E2100018
D2100007	E2100019
D2100008	E2100020
D2100009	E2100021
D2100010	E2100022
D2100011	E2100023
D2100012	E2100024

