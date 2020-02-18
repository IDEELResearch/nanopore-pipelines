#!/bin/bash
#SBATCH -n 1
#SBATCH -t 11-00:00:00
#SBATCH --mem 7Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user={kara_moser@med.unc.edu}

snakemake -s do-alignment.py --cluster "sbatch -n5 -t 5-00:00:00 --mem 7Gb " -j 8
