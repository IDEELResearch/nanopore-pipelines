###############################################################################
## Purpose:  SnakeMake File to prepare bam files from a minion nanopore run
## 	     using the NGMLR long read aligner

## Input: fastq files
## Output: bam files

# more info: https://github.com/philres/ngmlr

################################################################################

## CHANGE AS NEEDED

## Reference genome
REF = '/proj/ideel/resources/genomes/Tpallidum/Nichols_NC_021490.2.fasta'

## Required software
# samtools should be in your path (module load samtools)
ngmlr = '/nas/longleaf/home/kamoser/bin/ngmlr-0.2.7/ngmlr'

## Project specfic paths
workdir: '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/ngmlr' #sets working dir; most likely scratch
WRKDIR = '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/ngmlr' #setting string var

readWD = '/pine/scr/k/a/kamoser/nanopore-tpallidium/test-alignments/symlinks/' # where are your reads kept?

SAMPLES, = glob_wildcards(readWD + '{samp}.fastq') #getting samples

################################################################################

## PIPELINE RULES

# obligatory rule all (what files will this pipeline produce?)
rule all:
	input: expand('{samp}.sorted.bam.bai', samp = SAMPLES)

# align reads to reference 
rule align:
	input:
		readWD + "{samp}.fastq"
	output:
		"{samp}.sam"
	shell: 
		"{ngmlr} -t 4 -x ont --bam-fix \
		-r {REF} \
		-q {input} \
		-o {output}"

#convert sam to bam
rule convertsam:
	input:
		"{samp}.sam"
	output:
		"{samp}.bam"
	shell:
		"samtools view -Sbh {input} \
			> {output}"

#sort and index:
rule sort:
	input:
		"{samp}.bam"
	output:
		sorted = "{samp}.sorted.bam",
		index = "{samp}.sorted.bam.bai"
	run:
		shell("samtools sort {input} -o {output.sorted}")
		shell("samtools index {output.sorted}")

