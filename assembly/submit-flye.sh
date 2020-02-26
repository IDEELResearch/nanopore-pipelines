#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --time 10-12:00:00
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --mail-type=ALL
#SBATCH --error=canu-%j.err
#SBATCH --output=canu-%j.out

#Replace <STRING> with required text (removing <>)

#usage: flye (--pacbio-raw | --pacbio-corr | --nano-raw |
#	     --nano-corr | --subassemblies) file1 [file_2 ...]
#	     --genome-size SIZE --out-dir PATH
#	     [--threads int] [--iterations int] [--min-overlap int]
#	     [--meta] [--plasmids] [--no-trestle] [--polish-target]
#	     [--debug] [--version] [--help] [--resume] 
#	     [--resume-from] [--stop-after]

# Typical command:

data_d=/pine/scr/<O>/<N>/<ONYEN>/ #a single fastq file (preferably zipped) containing reads
work_d=/pine/scr/<O>/<N>/<ONYEN>/flye-assembly #where canu will right your output
mkdir -p $work_d

flye --nano-raw $data_d/combined.fastq.gz \
  --genome-size <SIZE> \ # example: 23m, 3g
  --out-dir $work_d
  
###################################################################################################

echo "Read through script."

###################################################################################################
  
