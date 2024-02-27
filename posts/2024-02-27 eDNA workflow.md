# Environmental DNA (eDNA) workflow 

I'm testing nf-core's ampliseq to be used with environmental DNA data generated with 12s amplicon sequencing (Offshore wind files that start with 501 (32 fastqc files)). 

> nfcore/ampliseq is a bioinformatics analysis pipeline used for amplicon sequencing, supporting denoising of any amplicon and supports a variety of taxonomic databases for taxonomic assignment including 16S, ITS, CO1 and 18S. Phylogenetic placement is also possible. Supported is paired-end Illumina or single-end Illumina, PacBio and IonTorrent data. Default is the analysis of 16S rRNA gene amplicons sequenced paired-end with Illumina.

### 12S 

MiFish 12S amplicon F:    
MiFish 12S amplicon R:    

#### metadata information 

The metadata file has to follow the QIIME2 specifications (https://docs.qiime2.org/2021.2/tutorials/metadata/). 



## Workflow Overview 

![](https://raw.githubusercontent.com/nf-core/ampliseq/2.8.0//docs/images/ampliseq_workflow.png)

### Pipeline summary

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

### Container information 

Singularity is the container loaded onto NU's cluster: https://sylabs.io/docs/. 

## Ampliseq

### Pipeline updates



`module load nextflow/23.10.1` 
`nextflow pull nf-core/ampliseq` 

### Slurm script 

`ampliseq.sh`:

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --time=40:00:00
#SBATCH --job-name=methylseq_ecoli
#SBATCH --mem=40GB
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2

# singularity module version 3.10.3
module load singularity/3.10.3

# nextflow module loaded on NU cluster is v23.10.1
module load nextflow/23.10.1

#set paths 
data="

cd /work/gmgi/Fisheries/ampliseq_tutorial

nextflow run nf-core/ampliseq -resume \
   -profile singularity \
   --input "data" \
   --FW_primer <seq> \
   --RV_primer <seq> \
   --outdir <OUTDIR> \
   --metadata <file>

```