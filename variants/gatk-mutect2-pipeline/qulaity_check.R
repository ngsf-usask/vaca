
mcf7_var_lit <- read.table("MCF7_variants_from_literature.txt", header=FALSE)

mcf7_var <- read.table("MCF7_A3B_uninduced.txt", header=FALSE)

mcf7_var$V1 <- gsub("^chr","", as.character(mcf7_var$V1))

#mcf7_var_lit[(mcf7_var_lit$chromosome %in% mcf7_var$V1) && (mcf7_var_lit$position %in% mcf7_var$V2)]


merge(mcf7_var,mcf7_var_lit, by=c('V1','V2'))

#SNVs extraction
#bcftools view MCF7_A3B_uninduced_concat.vcf.gz -v snps -o MCF7_A3B_uninduced.vcf.gz
#Required column Extraction
#bcftools query -f '%CHROM %POS %REF %ALT\n' MCF7_A3B_uninduced.vcf.gz > MCF7_A3B_uninduced.txt
