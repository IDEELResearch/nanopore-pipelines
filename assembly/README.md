## assembly scripts

- Scripts for:
  - <i>De novo</i> assembly using whole-genome sequencing data
  - <i>De novo</i> assembly using hybrid-capture sequencing data
  
## Some suggestions

### Assembly options for large eukaryotic
- Canu 

### Assembly options for small eukaryotic genomes
- Canu
  - For high AT rich genomes: correctedErrorRate=0.15
  - May time out due to default SLURM settings, so it's helpful to add:
    - `-gridOptions="--time=10-12:00:00"`
- Flye

### Assembly options for small viral genomes
<TO-COMPLETE>
  
### Assembly options for hybrid-capture data
<TO-COMPLETE>
