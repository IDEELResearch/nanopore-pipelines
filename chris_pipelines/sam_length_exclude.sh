#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

#Please probide a path with bam files
sample_list=$1
in_dir=/pine/scr/h/e/hennelly/Tp-Pilots_Report/filtered_sam
out_dir1=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e500
out_dir2=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e1000
out_dir3=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e2000
out_dir4=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e3000

############################################################################

# Things to change

#res="Tp-Pilot_picard_resources_v1"
#ref=""
#out_dir=""

############################################################################

array=($(ls $sample_list | cut -d'_' -f1,2))

for i in "${array[@]}"; do
 echo "$i"
  samtools view -h $in_dir/${i}_filtered.sam \
  | awk 'length($10) > 500 || $1 ~ /^@/' \
  | samtools view -bS - \
  > $out_dir1/${i}_e500.sam
done

for i in "${array[@]}"; do 
  samtools view -h $in_dir/${i}_filtered.sam \
  | awk 'length($10) > 1000 || $1 ~ /^@/' \
  | samtools view -bS - \
  > $out_dir2/${i}_e1000.sam
done

for i in "${array[@]}"; do
  samtools view -h $in_dir/${i}_filtered.sam \
  | awk 'length($10) > 2000 || $1 ~ /^@/' \
  | samtools view -bS - \
  > $out_dir3/${i}_e2000.sam
done

for i in "${array[@]}"; do
  samtools view -h $in_dir/${i}_filtered.sam \
  | awk 'length($10) > 3000 || $1 ~ /^@/' \
  | samtools view -bS - \
  > $out_dir4/${i}_e3000.sam
done


echo "Read through script."
