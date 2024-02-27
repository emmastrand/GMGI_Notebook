# Environmental DNA (eDNA) workflow 

I'm testing nf-core's ampliseq to be used with environmental DNA data generated with 12s amplicon sequencing (Offshore wind files that start with 501 (32 fastqc files)). 

> nfcore/ampliseq is a bioinformatics analysis pipeline used for amplicon sequencing, supporting denoising of any amplicon and supports a variety of taxonomic databases for taxonomic assignment including 16S, ITS, CO1 and 18S. Phylogenetic placement is also possible. Supported is paired-end Illumina or single-end Illumina, PacBio and IonTorrent data. Default is the analysis of 16S rRNA gene amplicons sequenced paired-end with Illumina.

## Workflow Overview 

![](https://raw.githubusercontent.com/nf-core/ampliseq/2.8.0//docs/images/ampliseq_workflow.png)

Pipeline summary:  
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

