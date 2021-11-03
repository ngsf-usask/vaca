gatk FilterMutectCalls \
   -V ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTPUT_DIR}/${OUTPUT_DIR}_somatic.vcf.gz \
   --min-allele-fraction 0.5 \
   -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTPUT_DIR}/${OUTPUT_DIR}_filtered.vcf.gz
