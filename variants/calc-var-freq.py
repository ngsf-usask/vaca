#!/usr/bin/env python3

import sys

vcf = sys.argv[1]

def get_depth(vcf_format_string, base):
    tab = {"A":4,"C":5,"G":6,"T":7}
    rec = vcf_format_string.split(":")
    tier1depth = rec[tab[base]].split(",")[0]

    return tier1depth


def calc_freq(ref, alt):
    tot = int(ref) + int(alt)
    try:
        freq = round(float(int(alt)/tot),3)
    except:
        freq = 1.0

    return freq

with open(vcf, "r") as infile:
    for line in infile:
        if line[0] == "#":
            sys.stdout.write(line)
        else:
            rec = line.split("\t")
            ref = rec[3]
            var = rec[4]
            refdepth = get_depth(rec[10], ref)
            altdepth = get_depth(rec[10], var)
            altfreq = calc_freq(refdepth, altdepth)
            rec[7] = f'{rec[7]};VAF={altfreq}'
            outbuff = "\t".join(rec)

            print(outbuff)
