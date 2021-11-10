 
 
 
#bcftools query -f '%CHROM %POS %DP [%AF]\n' MCF7_A3A_uninduced_concat.vcf.gz |tail -n 50
bcftools filter -i'FORMAT/DP>=15 && FORMAT/AF <=0.05' MCF7_A3A_uninduced_concat.vcf.gz | -l 


bcftools query -i'FORMAT/DP>=15 && AF <=0.05' -f'%CHROM %POS %REF %ALT %DP [%AF]\n' MCF7_A3A_uninduced_concat.vcf.gz -o MCF7_A3A_uninduced_filtered.vcf.gz
