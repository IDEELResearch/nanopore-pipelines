#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

#Please probide a path with bam files
sample_list=$1

in_dir1=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e500
out_dir1=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e500/lengths_e500

in_dir2=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e1000
out_dir2=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e1000/lengths_e1000

in_dir3=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e2000
out_dir3=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e2000/lengths_e2000

in_dir4=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e3000
out_dir4=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e3000/lengths_e3000

############################################################################

# Things to change 

############################################################################

array=($(ls $sample_list | cut -d'_' -f1,2))

for i in "${array[@]}"; do
 echo "$i"
 samtools view $in_dir1/${i}_e500.sam \
 | awk '{print length($10)}' \
 > $out_dir1/${i}_e500_lengths.txt
done

for i in "${array[@]}"; do
 echo "$i"
 samtools view $in_dir2/${i}_e1000.sam \
 | awk '{print length($10)}' \
 > $out_dir2/${i}_e1000_lengths.txt
done

for i in "${array[@]}"; do
 echo "$i"
 samtools view $in_dir3/${i}_e2000.sam \
 | awk '{print length($10)}' \
 > $out_dir3/${i}_e2000_lengths.txt
done

for i in "${array[@]}"; do
 echo "$i"
 samtools view $in_dir4/${i}_e3000.sam \
 | awk '{print length($10)}' \
 > $out_dir4/${i}_e3000_lengths.txt
done

echo "Read through script."
