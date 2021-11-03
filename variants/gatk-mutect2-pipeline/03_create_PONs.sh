#create Panel of Normals (PONs) using vcfs from previous step
gatk CreateSomaticPanelOfNormals \
      -R ${REF} \
      --germline-resource ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/af-only-gnomad.vcf.gz \
      -V ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/pon_db \
      -O ${HOME}/projects/${PROJECT_ID}/mutect2-pipeline/pon.vcf.gz
