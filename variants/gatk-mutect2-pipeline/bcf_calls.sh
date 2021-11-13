#!/bin/bash
#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=bcf-call
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=10:00:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load StdEnv/2020
module load gcc/9.3.0
module load bcftools/1.13

INPUT=''
REF='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'

bcftools mpileup -Oz -f ${REF} /globalhome/hxo752/HPC/projects/20-1LICH-001/mutect2-pipeline/merged_bam/D2100008_E2100020_merged.bam | bcftools call -mv -Oz -f GQ -o /globalhome/hxo752/HPC/projects/20-1LICH-001/mutect2-pipeline/merged_bam/calls.vcf.gz

#https://speciationgenomics.github.io/filtering_vcfs/
