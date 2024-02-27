# Nextflow: nf-core methylseq 

nf-core Methylseq pipeline (https://nf-co.re/methylseq/2.5.0) with the container set to Singularity. 

### General information from nf-core webpage

nf-core/methylseq is a bioinformatics analysis pipeline used for Methylation (Bisulfite) sequencing data. It pre-processes raw data from FastQ inputs, aligns the reads and performs extensive quality-control on the results.

The pipeline is built using Nextflow, a workflow tool to run tasks across multiple compute infrastructures in a very portable manner. It uses Docker / Singularity containers making installation trivial and results highly reproducible.

### Pipeline overview

The pipeline is built using Nextflow and processes data using the following steps:  
- FastQC - Raw read QC  
- TrimGalore - Adapter trimming  
- Genome Preparation - Bisulfite converting reference genome  
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

We did Whole Genome Bisulfite Sequencing across four lanes of a NovaSeq run. The biggest challenge so far for us is the amount of data to work with and the processing speed. In total there are 68 samples, each with R1,R2 reads. Which comes to ~1.9 TB worth of data.

Full samplesheet: metadata/samplesheet_NU_full.csv  
Subset samplesheet: metadata/samplesheet_NU_subset.csv

### slurm script 

`methyseq.sh`: 

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=long
#SBATCH --nodes=1
#SBATCH --time=120:00:00
#SBATCH --job-name=methylseq_subset
#SBATCH --mem=30GB
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2

cd /work/gmgi/Fisheries/epiage/haddock

# singularity module version 3.10.3
module load singularity/3.10.3

# nextflow module loaded on NU cluster is v23.10.1
module load nextflow/23.10.1

nextflow -log ./ run nf-core/methylseq -resume \
-profile singularity \
    --max_cpus 24 \
    --input metadata/samplesheet_NU_subset.csv \
    --outdir ./results \
    --multiqc_title haddockrun1 \
    --fasta ./OLKM01.fasta \
    --igenomes_ignore \
    --save_reference \
    --clip_r1 10 \
    --clip_r2 10 \
    --three_prime_clip_r1 10 \
    --three_prime_clip_r2 10 \
    --save_trimmed \
    --cytosine_report \
    --non_directional \
    --relax_mismatches \
    --num_mismatches 0.6
```

Issues during run:  
- The sym link to the fasta file within the work folder doesn't work.. I'm able to copy the .fasta into the work folder: `cp OLKM01.fasta /work/gmgi/Fisheries/epiage/haddock/work/62/6c6e7cbb7e8590677d7d4425e45e39/BismarkIndex/OLKM01.fasta`. This allows the program to resume running but is going to be annyoing to do every time.. This is post TrimGalore! before Bismark Align (~2 hours after the run starts for 6 files).

To see how efficient the script parameters (CPUs, mem, etc.): `seff [insert job ID]`. Example (stats from reference genome prep and TrimGalore! which take less resources than the Bismark align functions): 

```
Job ID: ## information removed 
Cluster: ## information removed 
User/Group: ## information removed 
State: FAILED (exit code 1)
Nodes: 1
Cores per node: 48
CPU Utilized: 1-16:24:21
CPU Efficiency: 39.23% of 4-06:59:12 core-walltime
Job Wall-clock time: 02:08:44
Memory Utilized: 21.00 GB
Memory Efficiency: 70.01% of 30.00 GB
```

Within `results/pipeline_info`, there are several execution reports: `execution_report_2024-02-16_15-52-36.html` and `execution_timeline_2024-02-16_15-52-36.html` that give more detailed information. Scp to desktop and open with a web browser. 
