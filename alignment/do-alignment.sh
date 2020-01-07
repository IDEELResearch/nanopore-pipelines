#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

###############################################################################

# kamoser
# Jan 2020

# ABOUT

# This pipeline takes zipped fastq files, aligns them to a reference with the 
# long-read aligner nglmr, and then generates summary statistics

# run as ./script <alignment option> (see below)

# TODO
# make updates so you can choose ngmlr or minimap (or both?)

###############################################################################

# To supply on the command line: 
# Would you like alignment using:
#   "minimap"
#   "ngmlr"
#   "both"

option=$1

###############################################################################

# Paths, env

#Required software
#samtools, ngmlr
#example:
#ngmlr=/nas/longleaf/home/kamoser/bin/ngmlr-0.2.7/ngmlr

#change as needed
data_d=<path_to_zipped_fastq>
work_d=<path_to_storage_(Normally scratch)>
ref=i<path_to_reference_genome>

mkdir -p $work_d
cd $work_d

###############################################################################

if [[ option == "minimap" ]]; then
  
  if [[ ]]; then 

    minimap2 -ax map-ont $ref $work_d/*fastq
    samtools view -S -b test.sam > ngmlr.bam
    samtools sort ngmlr.bam -o $b
    samtools index $b

    rm test.sam
    rm test.bam

  fi

else if [[ $option == "ngmlr" ]]; then

  b=ngmlr.sort.bam
  if [[ ! -e $b ]]; then

    $ngmlr -t 10 -r $ref -q $data_d/*fastq.gz -o test.sam

    samtools view -S -b test.sam > ngmlr.bam
    samtools sort ngmlr.bam -o $b
    samtools index $b

    rm test.sam
    rm test.bam

  fi

else if [[ option == "both" ]]; then



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
