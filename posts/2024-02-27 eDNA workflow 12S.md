# Environmental DNA (eDNA) workflow for vertebrate targets with 12S

### Workflow steps 

1. Nf-core Ampliseq: Implements CutAdapt and DADA2 pipelines (`01-ampliseq.sh`).     
2. LULU for distribution based post clustering curation of amplicon data (`02-lulu.sh`)
3. Taxonomic identification with blastn and taxonkit (`03-tax_ID.sh`).  

## 01. Nf-core ampliseq pipeline 

I'm testing nf-core's ampliseq to be used with environmental DNA data generated with 12s amplicon sequencing (Offshore wind vertebrate test). 

> nfcore/ampliseq is a bioinformatics analysis pipeline used for amplicon sequencing, supporting denoising of any amplicon and supports a variety of taxonomic databases for taxonomic assignment including 16S, ITS, CO1 and 18S. Phylogenetic placement is also possible. Supported is paired-end Illumina or single-end Illumina, PacBio and IonTorrent data. Default is the analysis of 16S rRNA gene amplicons sequenced paired-end with Illumina.

### Metadata 

#### 12S primer sequences (required)

Below is what we used for vertebrate testing between Riaz and Degenerate. 

MiFish 12S amplicon F: ACTGGGATTAGATACCCC...CTAGAGGAGCCTGTTCTA      
MiFish 12S amplicon R: TAGAACAGGCTCCTCTAG...GGGGTATCTAATCCCAGT     

#### Metadata sheet (optional) 

The metadata file has to follow the QIIME2 specifications (https://docs.qiime2.org/2021.2/tutorials/metadata/). Below is a preview of the sample sheet used for this test. Keep the column headers the same for future use. The first column needs to be "ID" and can only contain numbers, letters, or "-". This is different than the sample sheet. NAs should be empty cells rather than "NA". 

#### Samplesheet information (required)

This file indicates the sample ID and the path to R1 and R2 files. Below is a preview of the sample sheet used in this test. File created on RStudio Interactive on Discovery Cluster using (`create_metadatasheets.R`).  

- sampleID (required): Unique sample IDs, must start with a letter, and can only contain letters, numbers or underscores.  
- forwardReads (required): Paths to (forward) reads zipped FastQ files  
- reverseReads (optional): Paths to reverse reads zipped FastQ files, required if the data is paired-end  
- run (optional): If the data was produced by multiple sequencing runs, any string  

| sampleID            | forwardReads                                                                  | reverseReads                                                                  | run |
|---------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-----|
| Degen_501_1_Bottom  | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomDegen_R1.fastq.gz  | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomDegen_R2.fastq.gz  | 1   |
| Riaz_501_1_Bottom   | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomRiaz_R1.fastq.gz   | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomRiaz_R2.fastq.gz   | 1   |
| Degen_501_1_Surface | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1SurfaceDegen_R1.fastq.gz | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1SurfaceDegen_R2.fastq.gz | 1   |


### Workflow Overview 

![](https://raw.githubusercontent.com/nf-core/ampliseq/2.8.0//docs/images/ampliseq_workflow.png)

#### Pipeline summary

nf-core's ampliseq pipeline uses the following steps and programs. All programs are loaded by ampliseq. 
- Quality control (FastQC)   
- Trimming (Cutadapt)  
- Infer Amplicon Sequence Variants (DADA2)  
- Post-clustering (VSEARCH; optional)  
- Predict ribosomal RNA sequences from ASVs (Barnap)   
- Phylogenetic placement (EPA-NG)  
- Taxonomic classification (DADA2)  
- Exclude unwanted taxa, absolute/relative taxa count tables and plots, alpha rarefraction, alpha and beta diversity calculations (QIIME2)  
- Differentially abundant taxa (ANCOM)  
- Creates phyloseq R objects (Phyloseq)  
- Pipeline QC summaries (MultiQC)  
- Pipeline summary report (R Markdown)  

#### Container information 

Singularity is the container loaded onto NU's cluster: https://sylabs.io/docs/. 

#### Pipeline updates

> When you run the above command, Nextflow automatically pulls the pipeline code from GitHub and stores it as a cached version. When running the pipeline after this, it will always use the cached version if available - even if the pipeline has been updated since. To make sure that you’re running the latest version of the pipeline, make sure that you regularly update the cached version of the pipeline:

```
module load nextflow/23.10.1
nextflow pull nf-core/ampliseq
```

### Slurm script 

Slurm script to run: 

`01-ampliseq.sh`:

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --time=20:00:00
#SBATCH --job-name=ampliseq_notax
#SBATCH --mem=40GB
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2

# singularity module version 3.10.3
module load singularity/3.10.3

# nextflow module loaded on NU cluster is v23.10.1
module load nextflow/23.10.1

#set paths 
metadata="/work/gmgi/Fisheries/ampliseq_tutorial/metadata" 

cd /work/gmgi/Fisheries/ampliseq_tutorial

nextflow run nf-core/ampliseq -resume \
   -profile singularity \
   --input ${metadata}/samplesheet.csv \
   --metadata ${metadata}/metadata.tsv \
   --FW_primer "ACTGGGATTAGATACCCC...CTAGAGGAGCCTGTTCTA" \
   --RV_primer "TAGAACAGGCTCCTCTAG...GGGGTATCTAATCCCAGT" \
   --outdir ./results_notax \
   --trunclenf 100 \
   --trunclenr 100 \
   --trunc_qmin 25 \
   --max_len 200 \
   --max_ee 2 \
   --sample_inference pseudo \
   --skip_taxonomy
```

Spaces are not allowed after each \ otherwise nf-core will not read the parameter. 

**Notes**  

Adding in a custom database:

```
   --dada_ref_tax_custom ${metadata}/references/xx \
   --dada_ref_tax_custom_sp ${metadata}/references/xx
```

### Parameters  

Comprehensive list of parameters: https://nf-co.re/ampliseq/2.8.0/parameters 

Parameters included in this script:  
- `--trunclenf` / `--trunclenr`: DADA2 read truncation value for forward (f) / reverse strand (r), set this to 0 for no truncation. If not set, these cutoffs will be determined automatically for the position before the mean quality score drops below --trunc_qmin.  
- `--trunc_qmin`: Automatically determine --trunclenf and --trunclenr before the median quality score drops below --trunc_qmin. The fraction of reads retained is defined by --trunc_rmin, which might override the quality cutoff. A minimum value of 25 is recommended. However, high quality data with a large paired sequence overlap might justify a higher value (e.g. 35). Also, very low quality data might require a lower value. 
- `--max_len`: Remove reads with length greater than max_len after trimming and truncation. Must be a positive integer.  
- `--sample_inference`: If samples are treated independent (lowest sensitivity and lowest resources), pooled (highest sensitivity and resources) or pseudo-pooled (balance between required resources and sensitivity).   

### Output 

The following directories are created within `results`: `barrnap`, `cutadapt`, `dada2`, `fastqc`, `input`, `multiqc`, `pipeline_info`, and `summary report`. First thing to check is the execution report within `pipeline_info` to confirm all steps ran correctly with no errors. Then view the below files with dada2 output.

Quality Reporting files:  
- MultiQC Report: example; `multiqc/multiqc_report.html`.  
- Summary Report: example; `summary_report/summary_report.html`. 

Filtering summary: 
- CutAdapt and DADA2: `overall_summary.tsv` 

DADA2 output:  
- `ASV_seqs.fasta`, `ASV_table.tsv`, `DADA2_stats.tsv`, `DADA2_table.rds`, and `DADA2_table.tsv` will contain read counts for each ASV created. .rds is a R-object that be directly downloaded in RStudio and used for further analyses. 

## Custom config 

If a custom config file is needed, follow the below format with `process {withName: DADA2_FILTNTRIM {ext.args2 = "YOUR SETTINGS"}}`. Replace DADA2_FILTNTRIM with program step and your settings with values needed.

`ampliseqtutorial/fisheries12s.config`

```
process {
    withName: DADA2_DENOISING {
        ext.args2 = 'minOverlap = 106, maxMismatch = 0, returnRejects = FALSE, propagateCol = character(0), trimOverhang = TRUE, match = 1, mismatch = -64, gap = -64, homo_gap = NULL, endsfree = TRUE, vec = FALSE'
    }
}
```

To read in the config file, use `-c ./fisheries12.config` within the slurm script. 

## Custom database 

To use custom databases within DADA2 assignTaxonomy() and assignSpecies() functions (https://benjjneb.github.io/dada2/training.html), 2 different databases are needed. For `--dada_ref_tax_custom`, the .fasta reference file needs to have each header needs follow this format: `>Level1;Level2;Level3;Level4;Level5;Level6;` (e.g., `>Animalia;Chordata;Mammalia;Primates;Hominidae;Homo;Homo neanderthalensis;`). For `--dada_ref_tax_custom_sp`, each header needs to follow this format: `>ID Genus species` (`>GBGC16357-19 Homo neanderthalensis`). Multiple database comparisons are allowed but only one is forwarded to QIIME2 steps. The default on ampliseq is the SILVA reference taxonomy database.


# 2. Taxonomic Identification

### Databases 

For 12S, our team uses a curated database (GMGIVertRef.fasta), the Mitofish database (https://mitofish.aori.u-tokyo.ac.jp/download/), and NCBI nt database. To use NCBI's we use the -remote function to connect to the latest NCBI nt databases available. To prepare GMGI and the Mitofish database, 

```
## cd 
/work/gmgi/Fisheries/databases/12S/reference_fasta

## load modules needed 
module load ncbi-blast+/2.13.0

## prepare database 
makeblastdb -in Mitofish.fasta -dbtype nucl
makeblastdb -in GMGIVertRef.fasta -dbtype nucl
```

### TaxonKit 

I downloaded Taxonkit module (https://bioinf.shenwei.me/taxonkit/). This will take NCBI taxID output and include all taxonomic classifications associated with that ID. This modules is in the Fisheries/database repository and the following code is only for set-up. Users do not need to run again.

https://bioinf.shenwei.me/taxonkit/tutorial/

```
cd /work/gmgi/Fisheries/databases/taxonkit

# login to discovery and go to a compute node
srun --pty bash

# download the appropriate tar file
wget https://github.com/shenwei356/taxonkit/releases/download/v0.16.0/taxonkit_linux_amd64.tar.gz

# untar it (may need to navigate to the directory you want it, or move it later)
tar -xzvf taxonkit_linux_amd64.tar.gz

# test that it runs
./taxonkit
```

### Slurm script

The following script takes the `ASV_seqs.fasta` file from DADA2 output and uses `blastn` to compare sequences to three databases: Blast nt, Mitofish, and our in-house GMGI database.

Make a directory called `BLASToutput` within the project directory.

`02-tax_ID.sh`: 

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --time=20:00:00
#SBATCH --job-name=tax_ID
#SBATCH --mem=30GB
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2

## load modules needed 
module load ncbi-blast+/2.13.0

# set path to ASV_seqs.fasta
## needs to be changed for every project
fasta="/work/gmgi/Fisheries/ampliseq_tutorial/results_notax/dada2"
out="/work/gmgi/Fisheries/ampliseq_tutorial/taxonomic_assignment"
db="/work/gmgi/Fisheries/databases/12S/reference_fasta"
taxonkit="/work/gmgi/Fisheries/databases/taxonkit"

#### DATABASE QUERY ####
## NCBI database 
blastn -remote -db nt \
   -query ${fasta}/ASV_seqs.fasta \
   -out ${out}/BLASTResults_NCBI.txt \
   -max_target_seqs 10 -perc_identity 100 -qcov_hsp_perc 95 \
   -outfmt '6  qseqid   sseqid   sscinames   staxid pident   length   mismatch gapopen  qstart   qend  sstart   send  evalue   bitscore'

## Mitofish database 
blastn -db ${db}/Mitofish.fasta \
   -query ${fasta}/ASV_seqs.fasta \
   -out ${out}/BLASTResults_Mito.txt \
   -max_target_seqs 10 -perc_identity 100 -qcov_hsp_perc 95 \
   -outfmt '6  qseqid   sseqid  pident   length   mismatch gapopen  qstart   qend  sstart   send  evalue   bitscore'

## GMGI database 
blastn -db ${db}/GMGIVertRef.fasta \
   -query ${fasta}/ASV_seqs.fasta \
   -out ${out}/BLASTResults_GMGI.txt \
   -max_target_seqs 10 -perc_identity 100 -qcov_hsp_perc 95 \
   -outfmt '6  qseqid   sseqid   pident   length   mismatch gapopen  qstart   qend  sstart   send  evalue   bitscore'

############################

#### TAXONOMIC CLASSIFICATION #### 
## creating list of staxids from all three files 
awk -F $'\t' '{ print $4}' ${out}/BLASTResults_NCBI.txt | sort -u > ${out}/NCBI_sp.txt

## annotating taxid with full taxonomic classification
cat ${out}/NCBI_sp.txt | ${taxonkit}/taxonkit reformat -I 1 -r "Unassigned" > NCBI_taxassigned.txt
```

### Output 

- `BLASTResults_GMGI.txt`: GMGI's curated database results    
- `BLASTResults_Mito.txt`: MitoFish database results    
- `BLASTResults_NCBI.txt`: NCBI results    
- `NCBI_taxassigned.txt`: full taxonomic classification for all staxids found in NCBI output. 


# 3. Post-clustering curation with LULU algorithm 

LULU https://www.nature.com/articles/s41467-017-01312-x. LULU identifies errors by combining sequence similarity and co-occurrence patterns to remove erroneous ASVs. https://github.com/tobiasgf/lulu. I used this script within RStudio on NU cluster. 

### Input 

a. ASV (or OTU) table (`dada2/ASV_table.tsv`)

| OTUid | Sample1 | Sample2 | Sample3 | Sample4 | ...  |
|-------|---------|---------|---------|---------|------|
| OTU1  | 11      | 204     | 100     | 299     | ...  |
| OTU2  | 3       | 2201    | 100     | 388     | ...  |
| OTU3  | 0       | 20      | 130     | 10      | ...  |
| OTU4  | 147     | 0       | 0       | 9       | ...  |
| ...   | ...     | ...     | ...     | ...     |      |

b. ASV sequences fasta file (`dada2/ASV_seqs.fasta`)

```
OTU1
AGCGTGGTGSA...
OTU2
GGCGTATGCATGGTA...
OTU2
ATGGTAGGCGTATGC...
OTU4
GCGATGCGAT...
...
```

c. Match list created with blastn

This command is usually pretty quick so no need for a slurm script. 

Load ncbi-blast module: `module load ncbi-blast+/2.13.0`  
Make a blast formatted db from ASV seqs fasta file: `makeblastdb -in ASV_seqs.fasta -parse_seqids -dbtype nucl`  
Blastn to blast ASV seqs fasta against itself: `blastn -db ASV_seqs.fasta -outfmt '6 qseqid sseqid pident' -out match_list.txt -qcov_hsp_perc 90 -perc_identity 95 -query ASV_seqs.fasta`

The goal is to create a file that matches the format below: 

```
## file has no header but would be: OTU1  OTU2  pident
6a9c2d5770b6e78ca3450f62d67b08fc        6a9c2d5770b6e78ca3450f62d67b08fc        100.000
6a9c2d5770b6e78ca3450f62d67b08fc        8b8c58598b9195c46b3d8c5633ee4004        100.000
6a9c2d5770b6e78ca3450f62d67b08fc        ac3d4acf02381190b2e965d9581d94de        100.000
6a9c2d5770b6e78ca3450f62d67b08fc        6a126c48d6a97b60f15dc82c1c520270        100.000
6a9c2d5770b6e78ca3450f62d67b08fc        5a0bb678334b0e4217c228f2d8501644        100.000
6a9c2d5770b6e78ca3450f62d67b08fc        9682be6fbd648d7d3795747d603f3f65        99.057
6a9c2d5770b6e78ca3450f62d67b08fc        df173b369dc421debeb7bf75520533a5        99.057
6a9c2d5770b6e78ca3450f62d67b08fc        5fdc1adf1bf8cdaed504f5d29ce04a92        99.057
6a9c2d5770b6e78ca3450f62d67b08fc        64532675ee94b3e98fb68133e1a75984        99.057
6a9c2d5770b6e78ca3450f62d67b08fc        750f0840309a9989e3921313b36081a5        99.057
```

### R script

`03-lulu.R`: 

```
#library(devtools)
#install_github("tobiasgf/lulu")  
library(lulu)
library(ggplot2)
library(tidyr)

## read in data
otutab <- read.table("../../work/gmgi/Fisheries/eDNA/ampliseq_tutorial/results_notax/dada2/ASV_table.tsv", header=T, sep='\t', row.names = 1)
matchlist <- read.table("../../work/gmgi/Fisheries/eDNA/ampliseq_tutorial/results_notax/dada2/match_list.txt", header=FALSE,as.is=TRUE, stringsAsFactors=FALSE)

## run lulu 
curated_result <- lulu(otutab, matchlist, minimum_ratio_type = "min", minimum_ratio = 1, minimum_match = 99, minimum_relative_cooccurence = 0.95)

curated_table <- curated_result$curated_table
original_table <- curated_result$original_table

curated_result$curated_count
curated_result$discarded_count

otu_map <- curated_result$otu_map

## spot check those merged
gmgiblast <- read.table("../../work/gmgi/Fisheries/eDNA/ampliseq_tutorial/taxonomic_assignment/BLASTResults_GMGI.txt", header=F, sep='\t')
mitoblast <- read.table("../../work/gmgi/Fisheries/eDNA/ampliseq_tutorial/taxonomic_assignment/BLASTResults_Mito.txt", header=F, sep='\t')
```

Next steps: 
- `-remote` option within shell script for blast. Waiting on NU response then take 3 outputs and create R script to collapse and conduct filtering  
- LULU: why are there some ASVs with the same exact sequence?  