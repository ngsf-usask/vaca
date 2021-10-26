#!/usr/bin/python
#Load Required Packages
import isomut2py as im2
import pandas as pd
import sys
#####################
#Specify Paramenters
#####################
params=dict()
#ref genome
params['ref_fasta']='/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa'
#output dir
params['output_dir']=sys.argv[1]
#params['output_dir']='/datastore/NGSF001/projects/20-1LICH-0011/isomut2_results'
#input dir
params['input_dir']='/datastore/NGSF001/projects/20-1LICH-001/deduplication/august-2021/'
#params['input_dir']='/globalhome/hxo752/HPC/'
#the bam files used
params['bam_filename']=[sys.argv[2]]
#minimum number of blocks to run
params['n_min_block']=200
#number of concurrent processes to run
params['n_conc_blocks']=4

################
#Variant calling
################
mutDet = im2.mutationcalling.MutationCaller(**params)
mutDet.run_isomut2_mutdet()

#Optimize Results (for this step we have to supply uninduced samples. Induced samples will be compare against uninduced samples)
#mutDet.optimize_results(control_samples=['A3A-uninduced.sorted.bam'], FPs_per_genome=0)

##############################
#filtering SNV on score >= 3.2
##############################
mut_df = pd.read_csv(sys.argv[1] + '/all_SNVs.isomut2', sep='\t')

mut_df1 = mut_df[mut_df['score'] >= 3.2]

mut_df1.to_csv(sys.argv[1] + '/filtered_SNVs', sep='\t')

##################
#SNV Spectra Plot
##################
#ref_fasta = "/datastore/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa"
#mut_df = pd.read_csv(sys.argv[1] + '/all_SNVs.isomut2', sep='\t')
#mut_df = mut_df.rename(columns={"#sample_name": "sample_name"})


#SNV_spectra = im2.postprocess.calculate_SNV_spectrum(ref_fasta=ref_fasta,mutations_dataframe=mut_df)
#im2.plot.plot_SNV_spectrum(spectrumDict=SNV_spectra, normalize_to_1=True)

#from matplotlib import pyplot as plt

#plt.savefig("/globalhome/hxo752/HPC/projects/20-1LICH-001/SNV_spectra.pdf")

######################################################
#Decomposing mutational spectra to reference signatures
######################################################
#im2.postprocess.calculate_SNV_spectrum(ref_fasta=ref_fasta,mutations_dataframe=mut_df)

#decomp_snv_spec_plt = im2.postprocess.decompose_SNV_spectra(SNVspectrumDict=SNV_spectra)
#from matplotlib import pyplot as plt
#plt.savefig(sys.argv[1] + '/Decomp_SNV_spectra.pdf')
