gatk GenomicsDBImport -R ${REF} \
        --genomicsdb-workspace-path ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/pon_db \
        -V normal1.vcf.gz \
        -V normal2.vcf.gz \
        -V normal3.vcf.gz
