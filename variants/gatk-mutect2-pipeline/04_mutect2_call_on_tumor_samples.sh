gatk Mutect2 \
  -R ${REF} \
  -I ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_mdup_rg.bam \
  -L ${INTERVALS} \
  #--germline-resource af-only-gnomad.vcf.gz \
  --panel-of-normals ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/pon.vcf.gz \
  -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}_mutect2_final.vcf.gz
