#create Panel of Normals (PONs) using vcfs from previous step
gatk CreateSomaticPanelOfNormals \
    -vcfs ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/${OUTDIR_NAME}/${OUTDIR_NAME}.vcf.gz \
    -vcfs 4_NA19771.vcf.gz \
    -vcfs 5_HG02759.vcf.gz \
    -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/pon.vcf.gz
