# Environmental DNA (eDNA) workflow 

I'm testing nf-core's ampliseq to be used with environmental DNA data generated with 12s amplicon sequencing (Offshore wind files that start with 501 (32 fastqc files)). 

> nfcore/ampliseq is a bioinformatics analysis pipeline used for amplicon sequencing, supporting denoising of any amplicon and supports a variety of taxonomic databases for taxonomic assignment including 16S, ITS, CO1 and 18S. Phylogenetic placement is also possible. Supported is paired-end Illumina or single-end Illumina, PacBio and IonTorrent data. Default is the analysis of 16S rRNA gene amplicons sequenced paired-end with Illumina.

### 12S 

MiFish 12S amplicon F:    
MiFish 12S amplicon R:    

### Metadata information 

The metadata file has to follow the QIIME2 specifications (https://docs.qiime2.org/2021.2/tutorials/metadata/). Below is a preview of the sample sheet used for this test. Keep the column headers the same for future use. 

### Samplesheet information 

This file indicates the sample ID and the path to R1 and R2 files. Below is a preview of the sample sheet used in this test. 

- sampleID (required): Unique sample IDs, must start with a letter, and can only contain letters, numbers or underscores.  
- forwardReads (required): Paths to (forward) reads zipped FastQ files  
- reverseReads (optional): Paths to reverse reads zipped FastQ files, required if the data is paired-end  
- run (optional): If the data was produced by multiple sequencing runs, any string  

| sampleID            | forwardReads                                                                  | reverseReads                                                                  | run |
|---------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-----|
| Degen_501_1_Bottom  | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomDegen_R1.fastq.gz  | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomDegen_R2.fastq.gz  | 1   |
| Riaz_501_1_Bottom   | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomRiaz_R1.fastq.gz   | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1BottomRiaz_R2.fastq.gz   | 1   |
| Degen_501_1_Surface | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1SurfaceDegen_R1.fastq.gz | /work/gmgi/Fisheries/ampliseq_tutorial/raw_data/501-1SurfaceDegen_R2.fastq.gz | 1   |


File created on RStudio Interactive on Discovery Cluster using (`create_metadatasheets.R`). 

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

#### Container information 

Singularity is the container loaded onto NU's cluster: https://sylabs.io/docs/. 

#### Databases 

Multiple database comparisons are allowed but only one is forwarded to QIIME2 steps. The default on ampliseq is the SILVA reference taxonomy database.

## Ampliseq

### Pipeline updates

> When you run the above command, Nextflow automatically pulls the pipeline code from GitHub and stores it as a cached version. When running the pipeline after this, it will always use the cached version if available - even if the pipeline has been updated since. To make sure that you’re running the latest version of the pipeline, make sure that you regularly update the cached version of the pipeline:

```
module load nextflow/23.10.1
nextflow pull nf-core/ampliseq
```

### Slurm script 

`ampliseq.sh`:

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --time=20:00:00
#SBATCH --job-name=ampliseq
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
   --FW_primer "ACTGGGATTAGATACCCC...CTAGAGGAGCCTGTTCTA" \
   --RV_primer "TAGAACAGGCTCCTCTAG...GGGGTATCTAATCCCAGT" \
   --outdir ./results \
   --trunclenf 100 \
   --trunclenr 100 \
   --trunc_qmin 2 \
   --max_len 200 \
   --sample_inference pseudo \
   --skip_taxonomy TRUE \
   --skip_dada_taxonomy TRUE \
   --maxN 0 \
   --minOverlap 106 \
   --TrimOverhang TRUE



```

Spaces are not allowed after each \ otherwise nf-core will not read the parameter. 

**Notes**  
- `--max_ee` default is already 2 so I left out of script above. 
- Add max_len to make up for M=200 missing from cutadapt?  this should probably be less than 200 if it's after the trimming and trunc?
- Truncqmin is 2? Default is 25.. why so low?  
- Not sure if those databases will work b/c of the format of the header..

### Parameters  

https://nf-co.re/ampliseq/2.8.0/parameters 

Primer Removal  
- `--cutadapt_min_overlap`: Sets the minimum overlap for valid matches of primer sequences with reads for cutadapt (-O). Default is 3.  
- `--cutadapt_max_error_rate`: Sets the maximum error rate for valid matches of primer sequences with reads for cutadapt (-e). Default is 0.1.  
- `--double_primer`: Cutadapt will be run twice to ensure removal of potential double primers.  
- `--ignore_failed_trimming`: Ignore files with too few reads after trimming.  
- `--retain_untrimmed`: Cutadapt will retain untrimmed reads, choose only if input reads are not expected to contain primer sequences. 

Read Trimming and Quality Filtering  
- `--trunclenf` / `-trunclenr`: DADA2 read truncation value for forward (f) / reverse (r) strand, set this to 0 for no truncation.  
- `--trunc_qmin`: If `--trunclenf` and `--trunclenr` are not set, these values will be automatically determined using this median quality score. Default is 25.  
- `--trun_rmin`: Assures that values chosen with `--trunc_qmin` will retain a fraction of reads. Default is 0.75.  
- `--max_ee`: DADA2 read filtering option - After truncation, reads with higher than maxEE "expected errors" will be discarded. Expected errors are calculated from the nominal definition of the quality score: EE = sum(10^(-Q/10))). Default is 2. 
- `--min_len`: Remove reads with length less than min_len after trimming and truncation. Default is 50. 
- `--max_len`: Remove reads with length greater than max_len after trimming and truncation. Must be a positive integer. No default. 
- `--ignore_failted_filtering`: Ignore files with too few reads after quality filtering. 

Amplicon Sequence Variants (ASV) calculation  
- `--sample_inference`: Mode of sample inference: "independent", "pooled" or "pseudo". Default is independent.   
- `--concenatenate_reads`: Not recommended: When paired end reads are not sufficiently overlapping for merging. 

ASV post processing 
- `--vsearch_cluster`: Post-cluster ASVs with VSEARCH. T/F  
- `--vserach_cluster_id`: Pairwise Identity value used when post-clustering ASVs if `--vsearch_cluster` option is used (default: 0.97).  
- `--filter_ssu`: Enable SSU filtering. Comma separated list of kingdoms (domains) in Barrnap, a combination (or one) of "bac", "arc", "mito", and "euk". ASVs that have their lowest evalue in that kingdoms are kept.  
- `--min_len_asv`: Minimal ASV length  
- `--max_len_asv`: Maximum ASV length  
- `--filter_codons`: Filter ASVs based on codon usage  
- `--orf_start`: Starting position of codon tripletts  
- `--orf_end`: Ending position of codon tripletts  
- `--stop_codons`: Define stop codons

Taxonomic database 
- `--dada_ref_taxonomy`: Name of supported database, and optionally also version number. (e.g. silva=138). See https://nf-co.re/ampliseq/2.8.0/parameters#dada_ref_taxonomy for full list.  
- `--dada_ref_tax_custom`: Path to a custom DADA2 reference taxonomy database. Either `--skip_dada_addspecies` (no species annotation) or `--dada_ref_tax_custom_sp` (species annotation) is additionally required. Must be compatible to DADA2's assignTaxonomy function: 'Can be compressed. This reference fasta file should be formatted so that the id lines correspond to the taxonomy (or classification) of the associated sequence, and each taxonomic level is separated by a semicolon.' See also https://rdrr.io/bioc/dada2/man/assignTaxonomy.html 
- `--data_ref_tax_custom_sp`: Path to a custom DADA2 reference taxonomy database for species assignment. Must be compatible to DADA2's addSpecies function: 'Can be compressed. This reference fasta file should be formatted so that the id lines correspond to the genus-species binomial of the associated sequence.' See also https://rdrr.io/bioc/dada2/man/addSpecies.html.  
- `--dada_assign_taxlevels`: Comma separated list of taxonomic levels used in DADA2's assignTaxonomy function. Typically useful when providing a custom DADA2 reference taxonomy database with --dada_ref_tax_custom. If DADA2's addSpecies is used (default), the last element(s) of the comma separated string must be 'Genus' or 'Genus,Species'.    
- `--cut_dada_ref_taxonomy`: Expected amplified sequences are extracted from the DADA2 reference taxonomy using the primer sequences, that might improve classification. This is not applied to species classification (assignSpecies) but only for lower taxonomic levels (assignTaxonomy).  
- `--dada_addspecies_allowmultiple`: Defines the behavior when multiple exact matches against different species are returned. By default only unambiguous identifications are returned. If TRUE, a concatenated string of all exactly matched species is returned.  
- `--dada_taxonomy_rc`: If reverse-complement of each sequences will be also tested for classification.  
- `--pplace_tree`: Newick file with reference phylogenetic tree. Requires also --pplace_aln and --pplace_model.  
- `--pplace_aln`: File with reference sequences. Requires also --pplace_tree and --pplace_model.  
- `--pplace_model`: Phylogenetic model to use in placement, e.g. 'LG+F' or 'GTR+I+F'. Requires also --pplace_tree and --pplace_aln.  
- `--pplace_alnmethod`: Method used for alignment, "hmmer" or "mafft". Default is hmmer.   
- `--pplace_taxonomy`: Tab-separated file with taxonomy assignments of reference sequences.  
- `--qiime_ref_taxonomy`: Name of supported database, and optionally also version number. 