# Scripts for trimming and demultiplexing

- Use qcat for:
  - demultiplexing on known barcoding kits and trimming of adapters
  - currently does not support adapter trimming w/out barcodes

- Use porechop for:
  - demultiplexing on known barcoding kits and/or trimming of adapters
  - demultiplexing function is much slower than qcat
  
- Use pychoper for:
  - trimming primer and adapter sequences of cDNA
  - reorient sequences; can potentially rescue fused reads
