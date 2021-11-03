gatk FilterMutectCalls \
   -V somatic.vcf.gz \
   --min-allele-fraction 0.5 \
   -O filtered.vcf.gz
