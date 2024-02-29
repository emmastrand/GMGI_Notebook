# Environmental DNA (eDNA) workflow 

See eDNA workflow 12S for details on ampliseq. 

### Metadata 

#### CO1 primer sequences (required)

Leray Gellar CO1 amplicon F: GGWACWGGWTGAACWGTWTAYCCYCC  
Leray Gellar CO1 amplicon R: TANACYTCNGGRTGNCCRAARAAYCA 

I is replaced with N (https://cutadapt.readthedocs.io/en/stable/guide.html#wildcards). 


#### Metadata sheet (optional) 

The metadata file has to follow the QIIME2 specifications (https://docs.qiime2.org/2021.2/tutorials/metadata/). Below is a preview of the sample sheet used for this test. Keep the column headers the same for future use. The first column needs to be "ID" and can only contain numbers, letters, or "-". This is different than the sample sheet. NAs should be empty cells rather than "NA". 

File created on RStudio Interactive on Discovery Cluster using (`create_metadatasheets.R`).  

#### Samplesheet information (required)

This file indicates the sample ID and the path to R1 and R2 files. Below is a preview of the sample sheet used in this test. File created on RStudio Interactive on Discovery Cluster using (`create_metadatasheets.R`).  

### Slurm script 

I wrote a custom config file to change some default parameters for the Fisheries team. From the original modules.config file, I changed `

`ampliseq.sh`:

```
#!/bin/bash
#SBATCH --error=output_messages/"%x_error.%j" #if your job fails, the error report will be put in this file
#SBATCH --output=output_messages/"%x_output.%j" #once your job is completed, any final job report comments will be put in this file
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --time=20:00:00
#SBATCH --job-name=ampliseq_co1_negatives
#SBATCH --mem=40GB
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=2

# singularity module version 3.10.3
module load singularity/3.10.3

# nextflow module loaded on NU cluster is v23.10.1
module load nextflow/23.10.1

#set paths 
metadata="/work/gmgi/Fisheries/202402_negatives/metadata" 

cd /work/gmgi/Fisheries/202402_negatives

nextflow run nf-core/ampliseq -resume \
   -profile singularity \
   --input ${metadata}/samplesheet.csv \
   --metadata ${metadata}/metadata.tsv \
   --FW_primer "GGWACWGGWTGAACWGTWTAYCCYCC" \
   --RV_primer "TANACYTCNGGRTGNCCRAARAAYCA" \
   --outdir ./results \
   --trunc_qmin 25 \
   --trunclenr 200 \
   --trunclenf 215 \
   --max_ee 2 \
   --sample_inference pseudo \
   --skip_taxonomy
```

Spaces are not allowed after each \ otherwise nf-core will not read the parameter. 

**Notes**  
- COIDB - eukaryotic Cytochrome Oxidase I (COI) from The Barcode of Life Data System (BOLD) - COI
- Without taxonomy, this completed in 4 minutes and 30 seconds. 
- Dereplication is same as denoised.   
- maxN=0 is the default in the DADA2 trimming so no need to include. 

Flags from Fisheries team pipeline that I need to fold in:
- trimOverhang=TRUE, minOverlap=106 in merge step as these deviate from the defaults. Asked in the Slack group, if no response then create issue on github. 

Need to edit the config file here instead of adding flag?

