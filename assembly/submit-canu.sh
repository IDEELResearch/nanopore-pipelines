#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --time 10-12:00:00
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --mail-type=ALL
#SBATCH --error=canu-%j.err
#SBATCH --output=canu-%j.out

#Replace <STRING> with required text (removing <>)

module load canu/1.7

#Canu will launch a single job to the grid, and while that master canu command is running, will request and launch other jobs. It takes care of asking for the appropriate amount of resources.
#This script will be submitted to the grid, and will then end once the master canu command (below) is launched
#This seems a bit redundant, but I haven't been able to get it to run any other way with SLURM
#For SGE environments, all you have to do is submit the actual command on the command line. 

#usage: canu [-correct | -trim | -assemble] \
#            [-s <assembly-specifications-file>] \
#             -p <assembly-prefix> \
#             -d <assembly-directory> \
#             genomeSize=<number>[g|m|k] \
#             errorRate=0.X \
#            [other-options] \
#            [-pacbio-raw | -pacbio-corrected | -nanopore-raw | -nanopore-corrected] *fastq

###################################################################################################

#typical canu command to run all steps (correction, trimming, and assembling): 

data_d=/pine/scr/<O>/<N>/<ONYEN/ #a single fastq file (preferably zipped) containing reads
work_d=/pine/scr/k/a/kamoser/ovale_assembly/canu_v1 #where canu will right your output
mkdir -p $work_d

canu -p <NAME> \ # name of assembly (will produce <NAME>.contigs.fasta) as final
 -d $work_d \
 -nanopore-raw $data_d/combined.all.fastq.gz \
 #-pacbio-raw $data/combined.all.fastq.gz \ # example for pacbio data. can run both options at once if you have both nanopore + pacbio data
 genomeSize=<NUMBER> \ # Example: 23.3m for P. falciparum (include the m). This is mainly used to estimate genome coverage, so does not need to be exact
 #correctedErrorRate=0.15 \ only needed for AT rich genomes
 usegrid=TRUE \ #required to submit to grid. you can run locally, but trust me you don't want to do that
 -gridOptions="--time=10-12:00:00" #Average Pf genomes take somewhere between 2-4 days, bepending on the amount and quality of reads provided. 

###################################################################################################

echo "Read through script."

###################################################################################################

~                          
