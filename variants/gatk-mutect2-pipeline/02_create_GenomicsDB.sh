gatk GenomicsDBImport -R ${REF} -L {INTERVALS} \
        --genomicsdb-workspace-path pon_db \
        -V normal1.vcf.gz \
        -V normal2.vcf.gz \
        -V normal3.vcf.gz
