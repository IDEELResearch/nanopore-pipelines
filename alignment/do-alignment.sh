#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

###############################################################################

# kamoser
# Jan 2020

#Required software
#samtools, ngmlr
#example:
#ngmlr=/nas/longleaf/home/kamoser/bin/ngmlr-0.2.7/ngmlr

# ABOUT

# This pipeline takes zipped fastq files, aligns them to a reference with the 
# long-read aligner nglmr, and then generates summary statistics

# TODO
# make updates so you can choose ngmlr or minimap (or both?)

###############################################################################

#change as needed
data_d=<path_to_zipped_fastq>
work_d=<path_to_storage_(Normally scratch)>
ref=i<path_to_reference_genome>

mkdir -p $work_d
cd $work_d

###############################################################################

b=sort.bam
if [[ ! -e $b ]]; then

  $ngmlr -t 10 -r $ref -q $data_d/*fastq.gz -o test.sam

  samtools view -S -b test.sam > test.bam
  samtools sort test.bam -o $b
  samtools index $b

  rm test.sam
  rm test.bam

fi

f=alignment.flagstat
if [[ ! -e $f ]]; then
  samtools flagstat $b > $f 
fi

g=alignment.genomecov
if [[ ! -e $f ]]; then
  bedtools genomecov -d $b > $g
fi

###############################################################################

echo "Read through script."

###############################################################################
