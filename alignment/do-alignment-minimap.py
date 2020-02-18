###############################################################################
## Purpose:  SnakeMake File to prepare bam files from a demultiplexed minion 
#	     nanopore run using minimap and samtools

## Input: fastq files
## Output: bam files

################################################################################

shell.prefix("set -o pipefail; ")

################################################################################

## CHANGE AS NEEDED (<TEXT>)

## Reference genome
REF = '/proj/ideel/resources/genomes/<ORGANISM>/<NAME>.fasta' 

## Required software
# samtools should be in your path (`module load samtools` or other)
# To run minimap locally with precompiled binaries, see: https://github.com/lh3/minimap2#install
minimap2 = '/<FULL-PATH>/minimap2'

## Project specfic paths
workdir: '<FULL-PATH>' # where do you want your bam files to go? (*hint* probably scratch)
WRKDIR = '<FULL-PATH>' #setting string var

readWD = '<FULL-PATH>/' # where are your reads kept? should have unqiue names and end with "fastq"

SAMPLES, = glob_wildcards(readWD + '{samp}.fastq') #getting list of samples

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
		sorted = '{samp}.sorted.bam',
		index = '{samp}.sorted.bam.bai'
	run:
		shell('samtools sort {input} -o {output.sorted}')
		shell('samtools index {output.sorted}')

