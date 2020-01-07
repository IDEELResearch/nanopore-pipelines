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

f=combined.fastq.gz
if [[ ! -e $f ]]; then

  zcat $data_d/*fastq.gz > combined.fastq
  bgzip combined.fastq

fi

g=test.sort.bam
if [[ ! -e $g ]]; then

  $ngmlr -t 10 -r $ref -q combined_2kbp.fastq.gz -o test.sam

  samtools view -S -b test.sam > test.bam
  samtools sort test.bam -o $g
  samtools index $g

  rm test.sam
  rm test.bam

fi

h=sv.vcf
if [[ ! -e $h ]]; then

samtools 

fi

###############################################################################

echo "Read through script."

###############################################################################
