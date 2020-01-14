###############################################################################
## Purpose:  SnakeMake File to demultiplex fastq files from a minion nanopore run
## Authors:  Kara Moser

## Input: fastq files
## Output: demultiplexed fastq files

################################################################################

## CHANGE AS NEEDED

## Reference genome (don't need for this at the moment)
#REF = /proj/ideel/resources/genomes/Tpallidum/ 

## global software configuration; probably won't change much
# qcat should be installed and in your path

## Project specfic paths
#
workdir: '/proj/ideel/Seq_Reads/IDEEL_rawreads/Tpallidum/reupload/'

################################################################################

## PIPELINE RULES

# obligatory rule all
rule all:
	input:
		directory("demultiplexed-all/")

# Combine individual fastq files
rule concat:
	output:
		"combined.fastq"
	shell:
		"cat */*/*/*fastq > {output}"

# Demultiplex cominbed reads
rule demultiplexed:
	input:
		"combined.fastq"
	output:
		directory("demultiplexed-all/")
	shell:
		"qcat -f {input} -b {output}"
