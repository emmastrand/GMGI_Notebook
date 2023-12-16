# Nextflow: nf-core methylseq 

nf-core Methylseq pipeline (https://nf-co.re/methylseq/2.5.0) with the container set to Docker. 

### General information from nf-core webpage

nf-core/methylseq is a bioinformatics analysis pipeline used for Methylation (Bisulfite) sequencing data. It pre-processes raw data from FastQ inputs, aligns the reads and performs extensive quality-control on the results.

The pipeline is built using Nextflow, a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It uses Docker / Singularity containers making installation trivial and results highly reproducible.

### Pipeline overview

The pipeline is built using Nextflow and processes data using the following steps:  
- FastQC - Raw read QC  
- TrimGalore - Adapter trimming  
- Alignment - Aligning reads to reference genome  
- Deduplication - Deduplicating reads  
- Methylation Extraction - Calling cytosine methylation steps  
- Bismark Reports - Single-sample and summary analysis reports  
- Qualimap - Tool for genome alignments QC  
- Preseq - Tool for estimating sample complexity  
- MultiQC - Aggregate report describing results and QC from the whole pipeline  
- Pipeline information - Report metrics generated during the workflow execution  

### Dependencies

Dependencies that should be loaded by nextflow module:  
- fastQC/v0.12.1
- multiQC/v1.16
- trimgalore/v0.6.10
- cutadapt/v4.4
- picard/v3.1.0
- Bismark/v0.24.2
- bwa/v0.7.17
- qualimap/v2.3
- preseq/v3.2.0

### Raw data information 

We did Whole Genome Bisulfite Sequencing across four lanes of a NovaSeq run. The biggest challenge so far for us is the amount of data to work with and the processing speed. In total there are 68 samples, each with R1,R2 reads. Which comes to ~1.91 TB worth of data.

### slurm script 

```
#!/bin/bash
#SBATCH --error="script_error_fastqc" #if your job fails, the error report will be put in this file
#SBATCH --output="output_script_fastqc" #once your job is completed, any final job report comments will be put in this file

cd /work/gmgi/Fisheries/epiage/haddock

module load Nextflow/21.03.0 ##try newest version first

nextflow -log ./ run nf-core/methylseq -resume \
    --input metadata/samplesheet.csv \
    --outdir ./results \
    --email emma.strand@gmgi.org \
    --multiqc_title haddockrun1 \
    --fasta ./OLKM01.fasta.gz \
    --save_reference \
    --clip_r1 10 \
    --clip_r2 10 \
    --three_prime_clip_r1 10 \
    --three_prime_clip_r2 10 \
    --save_trimmed \
    --cytosine_report \
    --non_directional \
    --relax_mismatches \
    --num_mismatches 0.6 \
```