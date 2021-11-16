

#MCF7 variants from literature
mcf7_var_lit <- read.table("MCF7_variants_from_literature.txt", header=FALSE)

#SNVs extraction
#bcftools view MCF7_A3B_uninduced_concat.vcf.gz -v snps -o MCF7_A3B_uninduced.vcf.gz
#Required column Extraction
#bcftools query -f '%CHROM %POS %REF %ALT\n' MCF7_A3B_uninduced.vcf.gz > MCF7_A3B_uninduced.txt

#Mutect2 variants
mutect2_var <- function(sample_file){
mcf7_var <- read.table(sample_file, header=FALSE)
mcf7_var$V1 <- gsub("^chr","", as.character(mcf7_var$V1))
merge_var <- merge(mcf7_var_lit,mcf7_var, by=c('V1','V2'))
#paste0(sample_file,"=", merge_var[!duplicated(merge_var$V2),])
merge_var[!duplicated(merge_var$V2),]
}
mutect2_var("MCF7_A3A_uninduced.txt")
mutect2_var("MCF7_A3B_uninduced.txt")
mutect2_var("MCF7_A3H_uninduced.txt")



#Isomut2 variants
isomut2_var <- function(sample_file){
mcf7_var <- read.table(sample_file, header=FALSE)
mcf7_var$V1 <- gsub("^chr","", as.character(mcf7_var$V1))
merge_var <- merge(mcf7_var_lit,mcf7_var, by=c('V1','V2'))
#paste0(sample_file,"=", merge_var[!duplicated(merge_var$V2),])
merge_var[!duplicated(merge_var$V2),]
}

isomut2_var(E2100021)
isomut2_var(E2100016)
isomut2_var(E2100015)
isomut2_var(E2100023)
isomut2_var(E2100022)
isomut2_var(E2100017)
