#!/usr/bin/env python3

import sys
import gzip

from fastatools import fasta_iter

genome = {}
with open('/home/ahammond/NGSF001/analysis/references/human/gencode-30/GRCh38.primary_assembly.genome.fa','r') as infile:
    for sid, sqn in fasta_iter(infile):
        genome[sid] = sqn

newgenome = {}
for i in genome.keys():
    newkey = i.split(" ")[0]
    newgenome[newkey] = genome[i]

vcf = sys.argv[1]
with open(vcf, 'r') as infile:
    for line in infile:
        if line[0] == "#":
            print(line.strip())
        else:
            rec = line.strip().split("\t")
            chrom = rec[0]
            pos = rec[1]
            adj = int(pos) - 1
            upstream = adj - 2 # 2 bases upstream
            downstream = adj + 3 # 2 bases downstream with adjustment for slicing
            context = f';CON={newgenome[chrom][upstream:downstream]}'
            newinfo = rec[7]+context
            outbuff = rec[:7]
            outbuff.append(newinfo)
            outbuff.extend(rec[8:])
            print('\t'.join(outbuff))
