#!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=gatk-mutect2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=2:30:00
#SBATCH --mem=6G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out
set -eux

#loading required modules
module load gatk/4.2.2.0
module load picard
module load samtools

#reference file
REF='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'
PROJECT_ID='20-1LICH-001'
INTERVALS="/datastore/NGSF001/analysis/references/human/hg38/agilent_sureselect_human_all_exon_v8_hg38/S33266340_Covered.bed"
OUTDIR_NAME=$1
BAM_FILE=$2


#making project ID directory for storing results
mkdir -p ${HOME}/projects/${PROJECT_ID}/
mkdir -p ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}


#Run MarkDeduplication MarkDuplicates (https://gatk.broadinstitute.org/hc/en-us/articles/4405451219355-MarkDuplicatesSpark)
#Read Group Added
#Run Mutect2 in tumor only mode (https://gatk.broadinstitute.org/hc/en-us/articles/360035531132--How-to-Call-somatic-mutations-using-GATK4-Mutect2)

#run these commands for D21000* samples
samtools sort -o ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}.sorted.bam ${BAM_FILE} && \
java -jar $EBROOTPICARD/picard.jar MarkDuplicates I=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}.sorted.bam BARCODE_TAG="RX" O=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_markduplicates.bam M=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_marked_dup_metrics.txt && \
java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups I=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_markduplicates.bam o=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_mdup_rg.bam RGID=4 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=20 

#run these commands from E21000* samples
#java -jar $EBROOTPICARD/picard.jar MarkDuplicates I=${BAM_FILE} BARCODE_TAG="RX" O=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_markduplicates.bam M=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_marked_dup_metrics.txt && \
#java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups I=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_markduplicates.bam O=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_mdup_rg.bam RGID=4 RGLB=lib1 RGPL=ILLUMINA RGPU=unit1 RGSM=20 

#gatk Mutect2 -R ${REF} -L ${INTERVALS} -I ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/markduplicates.bam -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/unfiltered.vcf && \
#gatk FilterMutectCalls -R ${REF} -V ${HOME}/projects/${PROJECT_ID}/${OUTDIR_NAME}/unfiltered.vcf -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/filtered.vcf

#Validate samfile
#java -jar $EBROOTPICARD/picard.jar ValidateSamFile I=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/markduplicates.bam MODE=SUMMARY OUTPUT=${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/markduplicates.validated.txt

