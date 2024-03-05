# Environmental DNA (eDNA) workflow 

### Workflow steps 

1. Nf-core Ampliseq: Implements CutAdapt and DADA2 pipelines (`ampliseq.sh`).   
2. 

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

#### Databases 

Coming soon.

#### Pipeline updates

> When you run the above command, Nextflow automatically pulls the pipeline code from GitHub and stores it as a cached version. When running the pipeline after this, it will always use the cached version if available - even if the pipeline has been updated since. To make sure that you’re running the latest version of the pipeline, make sure that you regularly update the cached version of the pipeline:

```
module load nextflow/23.10.1
nextflow pull nf-core/ampliseq
```

### Slurm script 

Slurm script to run: 

`ampliseq_notax.sh`:

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

Quality Reporting files:  
- MultiQC Report: example; `multiqc/multiqc_report.html`.  
- Execution Report: example; `path`.  
- Summary Report: example; `summary_report/summary_report.html`. 

Filtering summary: 
- CutAdapt and DADA2: `overall_summary.tsv` 

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

To use custom databases within DADA2 assignTaxonomy() and assignSpecies() functions (https://benjjneb.github.io/dada2/training.html), 2 different databases are needed: 

For `--dada_ref_tax_custom`, each header needs follow this format: `>Level1;Level2;Level3;Level4;Level5;Level6;`. 

```

```

For `--dada_ref_tax_custom_sp`, each header needs to follow this format: `>ID Genus species`. 

```

```


Multiple database comparisons are allowed but only one is forwarded to QIIME2 steps. The default on ampliseq is the SILVA reference taxonomy database.

**Testing** 

I took Mitofish to test this. Each header looked like: `>Genus_sp` which wasn't compatible with QIIME2 so I used `sed 's/_/;/g' Mitofish.fasta > Mitofish_edited.fasta` to change this to `>Genus;sp` format. I then downloaded all fish taxonomic identifiers from fishbaseR (R_fishbase.R) to create a dataframe 

GMGIVertRef.fasta from RHEL to QIIME2 read-able version. There is more commentary in the headers for this file than I realized. Ditching this and going back to Mito.

```
## Remove all text before species name 
cut -d_ -f 4-6 GMGIVertRef.fasta > GMGIVertRef_sppID.fasta

## Add > header to every other row 
sed -i '1~2s/^/>/' GMGIVertRef_sppID.fasta

## Replace _ with a space 
sed -i 's/_/ /g' GMGIVertRef_sppID.fasta

## Create a list of all headers by grep ">" rows, print content after > and replace > with nothing to create new list
grep '>' GMGIVertRef_sppID.fasta | sed 's/^.*> //' | sed 's/>//g' > GMGIVertRef_headers.txt
```

Testing download from MitoFish website download 

Example of header:

> >gb|KY172980|Canthophrys_gongota (["Cypriniformes;"] ["Cobitidae;"])

Order, family, genus_species

cut -d| -f3 


**With GMGIVertRef 

--dada_ref_tax_custom <path>
--skip_dada_addspecies
--dada_assign_taxlevels Genus,species
--dada_addspecies_multiple TRUE


## Contribution to ampliseq 

### converting reference database to DADA2 format



### ref_database.config

https://github.com/nf-core/ampliseq/blob/master/conf/ref_databases.config

```
'mitofish' {
   title = "MitoFish: Mitochondrial Genome Database of Fish from 12S amplicon sequencing"
   file = [ "https://mitofish.aori.u-tokyo.ac.jp/species/detail/download/?filename=download%2F/complete_partial_mitogenomes.zip" ]
   citation = "Zhu T, Sato Y, Sado T, Miya M, and Iwasaki W. 2023. MitoFish, MitoAnnotator, and MiFish Pipeline: Updates in ten years. Mol Biol Evol, 40:msad035. doi:10.1093/molbev/msad035"
   fmtscript = "taxref_reformat_mitofish.sh"
   dbversion = "unversioned"
   taxlevels = "Order,Family,Genus,Species"
}
```

