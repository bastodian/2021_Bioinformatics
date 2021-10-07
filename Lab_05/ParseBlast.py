#!/usr/bin/env python3

import sys

BLAST_Results_File = sys.argv[1]

with open(BLAST_Results_File, 'r') as BLAST_Results:
    Line = BLAST_Results.readline()
    while Line:
        if '#' not in Line:
            LineAsList = Line.rstrip().split('\t')
            PercentIdentity = float(LineAsList[2])
            if PercentIdentity >= float(95):
                Query = LineAsList[0]
                DbHit = LineAsList[1]
                Evalue = LineAsList[-2]
                sys.stdout.write('%s,%s,%s,%s\n' % (Query, DbHit, Evalue, PercentIdentity))
                Line = BLAST_Results.readline()
            else:
                Line = BLAST_Results.readline()
        else:
            Line = BLAST_Results.readline()
