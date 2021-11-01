#!/usr/bin/env python3

import sys

vcf = sys.argv[1]

seen = set()

with open(vcf, "r") as infile:
    for line in infile:
        if line[0] == "#":
            sys.stdout.write(line)
        else:
            rec = line.split("\t")
            loc = str(rec[:2])
            gtype = rec[13]
            if gtype == "gene":
                if loc not in seen:
                    sys.stdout.write(line)
                    seen.add(loc)
