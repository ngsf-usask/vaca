 
 
 
#bcftools filter -i'FORMAT/DP>=15 && FORMAT/AF <=0.05' MCF7_A3A_uninduced_concat.vcf.gz -o MCF7_A3A_uninduced_filtered1.vcf.gz


bcftools query -i'FORMAT/DP>=15 && AF <=0.05' -f '%CHROM %POS %REF %ALT %DP [%AF] %TYPE\n' MCF7_A3A_uninduced_concat.vcf.gz -o MCF7_A3A_uninduced_filtered.vcf.gz
