#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace
#Please probide a path with bam files
sample_list=$1

in_dir1=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e500
in_dir2=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e1000
in_dir3=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e2000
in_dir4=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_e3000

out_dir1=/pine/scr/h/e/hennelly/Tp-Pilots_Report/picard_results/e500_metrics
out_dir2=/pine/scr/h/e/hennelly/Tp-Pilots_Report/picard_results/e1000_metrics
out_dir3=/pine/scr/h/e/hennelly/Tp-Pilots_Report/picard_results/e2000_metrics
out_dir4=/pine/scr/h/e/hennelly/Tp-Pilots_Report/picard_results/e3000_metrics

res=/pine/scr/h/e/hennelly/Tp-Pilots_Report/Tp-Pilot_picard_resources_v1

ref=/proj/ideel/resources/genomes/Tpallidum
############################################################################

############################################################################

array=($(ls $sample_list | cut -d'_' -f1,2))

module load picard

for i in "${array[@]}"; do
 
picard CollectHsMetrics \
	I=$in_dir1/${i}_e500.sam \
	O=$out_dir1/${i}_e500_metrics.txt \
	R=$ref/Nichols_NC_021490.2.fasta \
	TARGET_INTERVALS=$res/Tp_capture_targets_v1-2.interval_list \
	BAIT_INTERVALS=$res/Tp_probe_set_v1.interval_list \
	PER_TARGET_COVERAGE=$out_dir1/${i}_e500_tarcov.txt \
	PER_BASE_COVERAGE=$out_dir1/${i}_e500_basecov.txt \
	MINIMUM_MAPPING_QUALITY=0 \
	MINIMUM_BASE_QUALITY=10

done

for i in "${array[@]}"; do

picard CollectHsMetrics \
        I=$in_dir2/${i}_e1000.sam \
        O=$out_dir2/${i}_e1000_metrics.txt \
        R=$ref/Nichols_NC_021490.2.fasta \
        TARGET_INTERVALS=$res/Tp_capture_targets_v1-2.interval_list \
        BAIT_INTERVALS=$res/Tp_probe_set_v1.interval_list \
        PER_TARGET_COVERAGE=$out_dir2/${i}_e1000_tarcov.txt \
        PER_BASE_COVERAGE=$out_dir2/${i}_e1000_basecov.txt \
        MINIMUM_MAPPING_QUALITY=0 \
        MINIMUM_BASE_QUALITY=10

done

for i in "${array[@]}"; do

picard CollectHsMetrics \
        I=$in_dir3/${i}_e2000.sam \
        O=$out_dir3/${i}_e2000_metrics.txt \
        R=$ref/Nichols_NC_021490.2.fasta \
        TARGET_INTERVALS=$res/Tp_capture_targets_v1-2.interval_list \
        BAIT_INTERVALS=$res/Tp_probe_set_v1.interval_list \
        PER_TARGET_COVERAGE=$out_dir3/${i}_e2000_tarcov.txt \
        PER_BASE_COVERAGE=$out_dir3/${i}_e2000_basecov.txt \
        MINIMUM_MAPPING_QUALITY=0 \
        MINIMUM_BASE_QUALITY=10

done

for i in "${array[@]}"; do

picard CollectHsMetrics \
        I=$in_dir4/${i}_e3000.sam \
        O=$out_dir4/${i}_e3000_metrics.txt \
        R=$ref/Nichols_NC_021490.2.fasta \
        TARGET_INTERVALS=$res/Tp_capture_targets_v1-2.interval_list \
        BAIT_INTERVALS=$res/Tp_probe_set_v1.interval_list \
        PER_TARGET_COVERAGE=$out_dir4/${i}_e3000_tarcov.txt \
        PER_BASE_COVERAGE=$out_dir4/${i}_e3000_basecov.txt \
        MINIMUM_MAPPING_QUALITY=0 \
        MINIMUM_BASE_QUALITY=10

done

echo "Read through script."
