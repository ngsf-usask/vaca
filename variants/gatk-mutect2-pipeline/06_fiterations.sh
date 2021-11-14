 #!/bin/bash

#SBATCH --account=hpc_p_anderson
#SBATCH --constraint=skylake
#SBATCH --job-name=bcftools-filter
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --mem=2G
#SBATCH  --output=/globalhome/hxo752/HPC/slurm_logs/%j.out

set -eux

##loading required modules
module load StdEnv/2020
module load gcc/9.3.0
module load bcftools/1.13

PROJECT_ID='20-1LICH-001'
INPUT_DIR="${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/mutect2_calling/"
CLONE_ID=$1

#filter uninduced vcfs on Read Depth and Allele Frequency
bcftools filter \
              -i 'FORMAT/DP>=15 && FORMAT/AF <=0.05' \
              ${INPUT_DIR}${CLONE_ID}_uninduced_concat.vcf.gz \
              -o ${INPUT_DIR}${CLONE_ID}_uninduced_filtered.vcf.gz

#bcftools query -i 'FORMAT/DP>=15 && AF <=0.05' -f '%CHROM %POS %REF %ALT %DP [%AF] %TYPE\n' MCF7_A3A_uninduced_concat.vcf.gz -o MCF7_A3A_uninduced_filtered.vcf.gz

#https://gatk.broadinstitute.org/hc/en-us/community/posts/360076993852-QUAL-values-not-present-in-Mutect2-VCF
