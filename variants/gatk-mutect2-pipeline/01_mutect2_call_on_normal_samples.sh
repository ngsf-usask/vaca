#Run Mutect2 in tumor only mode (https://gatk.broadinstitute.org/hc/en-us/articles/360035531132--How-to-Call-somatic-mutations-using-GATK4-Mutect2
#https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2)
#First Run Mutect2 on normal samples to generate VCFs
gatk Mutect2 \
     -R ${REF} \
     --max-mnp-distance 0 \
     -I ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_mdup_rg.bam \
     -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}.vcf.gz
