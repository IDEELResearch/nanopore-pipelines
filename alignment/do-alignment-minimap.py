###############################################################################
## Purpose:  SnakeMake File to prepare bam files from a minion nanopore run
#	     using minimap

## Input: fastq files
## Output: bam files

################################################################################

shell.prefix("set -o pipefail; ")

################################################################################

## CHANGE AS NEEDED

## Reference genome
REF = '/proj/ideel/resources/genomes/Tpallidum/Nichols_NC_021490.2.fasta' 

## Required software
# samtools should be in your path (`module load samtools` or other)
minimap2 = '/nas/longleaf/home/kamoser/bin/minimap2-2.17_x64-linux/minimap2'

## Project specfic paths
workdir: '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/minimap'
WRKDIR = '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/minimap' #setting string var

readWD = '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/symlinks' # where are your reads kept?

SAMPLES, = glob_wildcards(readWD + '{samp}.fastq') #getting samples

################################################################################

## PIPELINE RULES

# Obligatory rule all (what files will this pipeline produce?)
rule all:
	input: expand('{samp}.sorted.bam.bai', samp = SAMPLES)

# Align reads to reference
rule align:
	input: 
		readWD + '{samp}.fastq'
	output:
		'{samp}.bam'
	shell:
		'minimap2 -t 4 -ax map-ont {REF} {input} \
			| samtools view -Shb - \
			> {output}'

# Sort and index bam file
rule sort:
	input:
		'{samp}.bam'
	output:
		'{samp}.sorted.bam.bai'
	run:
		shell('samtools sort {input} -o {samp}.sorted.bam')
		shell('samtools index {samp}.sorted.bam')

