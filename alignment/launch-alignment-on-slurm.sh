#!/bin/bash
#SBATCH -n 5
#SBATCH -t 4-00:00:00
#SBATCH --mem 7Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user={kara_moser@med.unc.edu}

module load samtools

snakemake -s do-alignment-ngmlr.py --cluster "sbatch -n5 -t 4-00:00:00 --mem 7Gb " -j 8
