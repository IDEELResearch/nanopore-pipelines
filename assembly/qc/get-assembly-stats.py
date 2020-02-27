#!/usr/bin/env python

#Author: kmoser
#python3
# Takes a fasta file with multiple sequences and reports: 
# - number of contigs
# - Cumluative length of all contigs
# - n50 of all contigs

#usage: ./find-assembly-stats.py <assembly.fasta>

import sys
import Bio
from Bio import SeqIO
import numpy

fasta_file=sys.argv[1] #input fasta file

sequences = list(SeqIO.parse(open(fasta_file),"fasta"))
sequences.sort(key=lambda r: len(r))

count=0
cl=0
lengths=[]
for i in (sequences):
  count += 1
  cl += len(i)
  lengths.append(len(i))

half = cl / 2
bps = 0
for l in reversed(lengths):
  bps += l
  if bps >= half:
    n50 = l
    break

# DON'T DO THIS I KNOW YOU WANT TO BUT IT'S WRONG
#n50 = statistics.median(lengths)

print("Num.Contigs","Cum.Length","n50",sep='\t')
print(count,cl,n50,sep='\t')
