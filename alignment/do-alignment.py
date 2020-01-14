###############################################################################
## Purpose:  SnakeMake File to demultiplex fastq files from a minion nanopore run
## Authors:  Kara Moser

## Input: fastq files
## Output: bam files

################################################################################

## CHANGE AS NEEDED

## Reference genome
REF = /proj/ideel/resources/genomes/Tpallidum/ 

## global software configuration; probably won't change much
minimap = '/nas/longleaf/home/kamoser/bin/minimap2-2.17_x64-linux/minimap2'
ngmlr = '/nas/longleaf/home/kamoser/bin/ngmlr-0.2.7/ngmlr'
picard = '/proj/ideel/apps/linuxbrew/Cellar/picard-tools/2.18.4/bin/picard'

## Project specfic paths
workdir: '/pine/k/a/kamoser/TpP1-alignments' #sets working dir; most likely scratch
WRKDIR = '/pine/k/a/kamoser/TpP1-alignments' #setting string var
readWD = '/proj/ideel/jonbparrlab/users/kmoser/2001/TpP1-project/data-symlinks/' # where are your reads kept?
SAMPLES, = glob_wildcards(readWD + '{samp}.fastq.gz') #getting samples
MERGEDSAMPS, = glob_wildcards(WRKDIR + 'aln/{ms}.merged.bam')
MTDT = '/nas/longleaf/home/kamoser/daily/2001/nanopore-projs/metadata.txt'

################################################################################

## PIPELINE RULES

# obligatory rule all (what files will this pipeline produce?)
rule all:
	input: expand('aln/{samp}.bam', samp = SAMPLES)
	input: expand('aln/{merge}.bam.bai', merge = MERGEDSAMPS)

# Align reads to reference
rule align-minimap:
	input: 
		"{samp}.fastq"
	output:
		"{samp}.minimap.bam"
	shell:
		"minimap2 -ax map-ont {REF} \
			{samp}.fastq \
			> {output}"

# 
rule align-ngmlr:
	input:
		"combined.fastq"
	output:
		directory("demultiplexed-all/")
	shell: 
		"qcat -f {input} -b {output}"
