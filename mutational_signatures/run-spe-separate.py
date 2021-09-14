#!/usr/bin/env python3

import sys

from SigProfilerExtractor import sigpro as sig

infile = sys.argv[1]

def main_function():
    # to get input from vcf files
    path_to_data = infile
    sig.sigProfilerExtractor("vcf", ".", path_to_data, minimum_signatures=1, maximum_signatures=3, \
        reference_genome="GRCh38", opportunity_genome="GRCh38", cpu=4, exome=True)

if __name__=="__main__":
   main_function()
