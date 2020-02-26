### Scripts for assembly generation and qc

This directory contains submission scripts for previously developed assembler programs to the longleaf environment, as well as some helpful scripts to quickly gather assembly statistics

## Some suggestions

### Assembly options for large eukaryotic genomes
- Canu 

### Assembly options for small eukaryotic genomes
- Canu
  - Can handle nanopore and pacbio data (or both together for hybrid assemblies)
  - For high AT rich genomes: 
     `correctedErrorRate=0.15`
  - May time out due to default SLURM settings, so it's helpful to add:
     `-gridOptions="--time=10-12:00:00"`
- Flye

### Assembly options for small viral genomes
<TO-COMPLETE>
  
### Assembly options for hybrid-capture data
<TO-COMPLETE>
