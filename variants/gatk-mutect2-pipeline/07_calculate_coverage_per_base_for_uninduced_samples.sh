#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=samtools_mpileup
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=4:00:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

##loading required modules
module load StdEnv/2020
module load gcc/9.3.0
module load bcftools/1.13

REF='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'
PROJECT_ID='20-1LICH-001'
INPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/merged_bam/"
CLONE_ID=$1

echo "${INPUT_DIR}/${CLONE_ID}_uninduced_concat.bam" >> ${CLONE_ID}_uniduced_bam.txt

bcftools mpileup -f ${REF} -b ${CLONE_ID}_uniduced_bam.txt -o ${INPUT_DIR}/${CLONE_ID}_mpileup.uniduced.vcf.gz -O z

#bcftools filter -s LowQual -e '%DP>=15' > ${INPUT_DIR}_${CLONE_ID}.flt.vcf
            
            
