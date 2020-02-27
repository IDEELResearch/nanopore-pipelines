# nanopore-pipelines
Scripts and pipelines for analyzing Oxford Nanopore long-read data

**Use at your own risk**

## Required and Recommended software

- Bioconda (installation instructions here)

- Porechops
- qcat
- minimap2
- ngmlr

## Instructions for removing data from MinIT

- Connect to minit hostpot using instructions in stupid card

- On the command line, ssh into the minit device (the IP address aparently is the same for all minit machines, and the password is also listed on the card (come find Kara or Chris if you don't can't find it):

`ssh minit@10.42.0.1`

- The directory structure of the minit looks like this:

`$ tree
<insert directory heirachy>`

- The data is stored in `/data`
- Other devices connected to the minit will be in `/media` (or possibly `/mnt`)

- To move data from the minit to an external drive, do the following:
  1) Plug in external hard drive to the minit
  2) nohup cp -r /data/$folder-of-interest /media/$name-of-external-HD &
  
  You can now `exit` from the minit 
  
  - To transfer to longleaf
    If you would like to click 'n drag:
      1) Plug in external HD with data; make sure it's mounted/your computer recognizes it in the finder
      2) Mount longleaf `<insert commands>`
      3) You can either click and drag through the finder, or use a command like scp to transfer data from the external HD to longleaf on the command line `<insert example command>`
