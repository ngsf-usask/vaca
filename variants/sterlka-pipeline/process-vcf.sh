#!/bin/bash

mkdir -p annotated-vcf

for i in $(echo A3A-I4_strelka A3A-I5_strelka A3B-I2_strelka A3B-I5_strelka A3H-I4_strelka A3H-I6_strelka); do
    zcat ${i}/results/variants/somatic.snvs.vcf.gz > annotated-vcf/${i}.somatic.vcf && \
    ./annotate-vcf.py annotated-vcf/${i}.somatic.vcf > annotated-vcf/${i}.somatic.annot1.vcf && \
    bedtools sort -header -i annotated-vcf/${i}.somatic.annot1.vcf > \
        annotated-vcf/${i}.somatic.annot1.bedtoolsSorted.vcf && \
    bedtools closest -header -a annotated-vcf/${i}.somatic.annot1.bedtoolsSorted.vcf \
        -b ../gencode.v30.annotation.noMito2.bedtoolsSorted.gtf > \
        annotated-vcf/${i}.somatic.annotated.vcf && \
    awk '/^#/ || $7=="PASS"' annotated-vcf/${i}.somatic.annotated.vcf > \
        annotated-vcf/${i}.somatic.annotated.PASS.vcf
done
