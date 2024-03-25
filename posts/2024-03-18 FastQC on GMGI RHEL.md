# Quality Control of raw WGBS data 

Whole Genome Bisulfite Sequencing data from NovaSeq S4 300 cycle platform (NovaSeq 6000 S4 Reagent Kit v1.5 (300 cycles), catalog number 20028312 from Illumina). DNA Extraction and library preparation laboratory methods can be found in this repository in the 'Epigenetic_aging\protocols and lab work' folder. 

## Setting up project on HPC 

GMGI works with a Red Hat Enterprise Linux (RHEL) server. All data and scripts are kept on this server. Output files are downloaded to my desktop for analyses in R.

Within `/data/prj/Fisheries`, I created a new folder for epigenetic aging projects and within that new folder, I created a Haddock directory. Within the Haddock directory, I created raw data and scripts folders. 

```
mkdir epiage
cd epiage
mkdir haddock
mkdir haddock/raw_data
mkdir haddock/scripts
mkdir haddock/fastqc_results
mkdir haddock/fastqc_results/screen_results

[estrand@gadus haddock]$ ls
## fastqc_results  raw_data  scripts
```

Raw data was transfered directly from UConn's Globus web interface to GMGI's RHEL server.

# FastQC, FastQ Screen, and MultiQC on all raw files 

FastQC: https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ (v0.12.1)  
MultiQC: https://multiqc.info/ (v1.16)  
Fastq Screen: https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen/  (v0.15.3). This program maps reads to reference genomes to give you can idea of the proportion of reads mapped, in this project, to E.coli and Haddock.

Wingett SW and Andrews S. FastQ Screen: A tool for multi-genome mapping and quality control [version 2; referees: 4 approved]. F1000Research 2018, 7:1338 (https://doi.org/10.12688/f1000research.15931.2). 

### Adding Haddock genome to my folder 

Melanogrammus aeglefinus (haddock): https://www.ebi.ac.uk/ena/browser/view/GCA_900291075 and https://link.springer.com/article/10.1186/s12864-018-4616-y. 

```
## WGS contig information
$ cd /data/prj/Fisheries/epiage/haddock
$ wget hftp://ftp.ebi.ac.uk/pub/databases/ena/wgs/public/olk/OLKM01.fasta.gz
```

### Downloading reference genomes within fastq screen

Obtaining reference genomes from Fastq screen:

I'm using a tmux screen so I'm able to disconnect from the internet if I need to and it will still run.

```
$ tmux new -s FastQ-Screen
$ cd /data/prj/Fisheries/epiage
$ module load fastq-screen/v0.15.3
$ fastq_screen --get_genomes
```

Detach from a tmux session: Press Ctrl+B, release, and then press D. This is still running in the background.

The genome indices will be downloaded to a folder named "FastQ_Screen_Genomes" in your current working directory (or to another location if --outdir is specified). In addition to the genome indices, the folder FastQ_Screen_Genomes will contain a configuration file named "fastq_screen.conf", which is ready to use and lists the correct paths to the newly downloaded reference genomes. This configuration file can be passed to fastq_screen with the --conf command, or may be used as the default configuration by copying the file to the folder containing the fastq_screen script.

I'm downloading all of the genomes here so I can get the other files within the FastQ_Screen_Genomes folder. I really only need E.coli and Haddock genome. Next time I might not need the entire screen genomes folder? But I needed the config file and wanted to see the other contents.


## Creating and running the script

### FastQC and MultiQC
  
Create a new session: `tmux new -s fastqc`   
To run script `bash name.sh`   
To go back into a session: `tmux attach-session -t fastqc`  
`^Z` to stop a script from running.

`top -u estrand` to check the processes I'm running. and `q` to escape top view screen. 

`fastqc.sh` (path = /data/prj/Fisheries/epiage/haddock/scripts)

```
#!/bin/bash
#bash --error="script_error_fastqc" #if your job fails, the error report will be put in this file
#bash --output="output_script_fastqc" #once your job is completed, any final job report comments will be put in this file

module load fastQC/v0.12.1
module load multiQC/v1.16

cd /data/prj/Fisheries/epiage/haddock/ 

# Set CPU threads to use
threads=20

for file in ./raw_data/*fastq.gz
do
    fastqc $file \
        --outdir ./fastqc_results/ \
        --threads ${threads}      
done

multiqc --interactive ./fastqc_results
```

### FastQC Screen

*Currently troubleshooting this script. come back to this.. I'd like to know right away the proportion of reads mapped to E.coli vs. Haddock, but getting an error in the config file. I didn't run this for now.* 

Create a new session: `tmux new -s fastqc_screen`   
`bash fastqc_screen.sh`   
To go back into a session: `tmux attach-session -t fastqc_screen`  

`fastqc_screen.sh` (path = /data/prj/Fisheries/epiage/haddock/scripts)

```
#!/bin/bash

module load fastq-screen/v0.15.3

cd /data/prj/Fisheries/epiage/haddock/ 

for file in ./raw_data/*fastq.gz
do
    fastq_screen $file \
        --conf ../FastQ_Screen_Genomes/fastq_screen.conf \
        --add_genome Haddock,/data/prj/Fisheries/epiage/haddock/OLKM01.fasta,Notes \
        --bisulfite \
        --outdir ./fastqc_results/screen_results/       
done
```