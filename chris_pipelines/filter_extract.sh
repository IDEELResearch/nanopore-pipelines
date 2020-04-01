human_ref=GCF_000001405.39_GRCh38.p13_genomic.fna.gz
tp_ref=/proj/ideel/resources/genomes/Tpallidum/Nichols_NC_021490.2.fasta

#name=Sample01
reads=/nas/longleaf/home/hennelly/ideel-Tpallidum/Tp-Pilot2/Tp-Pilot2_demultiplexed
#Tp-Pilot1_fastq_directory=/nas/longleaf/home/hennelly/ideel-Tpallidum/Tp-Pilot1/demultiplexed-trimmed
#Tp-Pilot2_fastq_directory=/nas/longleaf/home/hennelly/ideel-Tpallidum/Tp-Pilot2/Tp-Pilot2_demultiplexed
#out_dir=Tp_Pilot2_jrw_alignments
#i=Tp-Pilot2_Sample01
array=($(ls $reads | cut -d'.' -f1))

for i in "${array[@]}"; do


if [ ! -s ${i}_reads_to_human.paf ]; then
  minimap2 -t 4 -cx map-ont $human_ref $reads/${i}.fastq --secondary=no > ${i}_reads_to_human.paf
fi

if [ ! -s ${i}_reads_to_tp.paf ]; then
  minimap2 -t 4 -cx map-ont $tp_ref $reads/${i}.fastq --secondary=no > ${i}_reads_to_tp.paf
fi

aln_fraction_threshold=0.3
accuracy_threshold=0.8

echo "$i:"
awk 'FNR==NR{
  if(($4 - $3) / $2 > '$aln_fraction_threshold' && $10/$11 > '$accuracy_threshold') {
    human += 1;
    is_human[$1] = 1;
  }
} FNR!=NR{
  if(!($1 in is_human) && ($4 - $3) / $2 > '$aln_fraction_threshold' && $10/$11 > '$accuracy_threshold') {
    tp += 1;
    {print $1 > "filtered_reads_text2/'${i}'_reads_extract.txt"};
  }  
} END {
  print human" human reads"
  print tp" T.pallidum reads"
}' ${i}_reads_to_human.paf ${i}_reads_to_tp.paf


done

echo "Read through script."
