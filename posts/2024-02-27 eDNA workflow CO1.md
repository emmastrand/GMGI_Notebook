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
   --dada_ref_taxonomy coidb
```

Flags to complete with taxonomy: 
- `--skip_taxonomy TRUE`: only performs CutAdapt and DADA2 workflows.  

Flags to complete taxonomy using DADA2 (vs. QIIME2) for COI:  
- `--dada_ref_taxonomy coidb`: COIDB - eukaryotic Cytochrome Oxidase I (COI) from The Barcode of Life Data System (BOLD). This takes the most updated version. 


Spaces are not allowed after each \ otherwise nf-core will not read the parameter. 

**Notes**  
- COIDB - eukaryotic Cytochrome Oxidase I (COI) from The Barcode of Life Data System (BOLD) - COI
- Without taxonomy, this completed in 4 minutes and 30 seconds. 
- Dereplication is same as denoised.   
- maxN=0 is the default in the DADA2 trimming so no need to include. 

Flags from Fisheries team pipeline that I need to fold in:
- trimOverhang=TRUE, minOverlap=106 in merge step as these deviate from the defaults. Asked in the Slack group, if no response then create issue on github. 
- use separate config to add in

COIDB qiime2 process is stalling? Transfer seqs and tables to RHEL for blastn database that is already downloaded. Just for this answer. 

### RHEL blastn

File: `ASV_seqs.fasta` 

```
tmux new -s COIcontaminationBlast
module load blast/v2.14.1
blastn -query ASV_seqs.fasta -db /data/resources/databases/blastdb/nt -out BLASTResults_COIcontamination.txt -max_target_seqs 10 -perc_identity 100 -qcov_hsp_perc 95 -outfmt 6

blastn -query ASV_seqs.fasta -db /data/resources/databases/blastdb/nt -out BLASTResults_COIcontamination99.txt -max_target_seqs 10 -perc_identity 99 -qcov_hsp_perc 95 -outfmt 6
```

Check usage: `top` or `top -u estrand`. 
Ctrl+B then release and click D to detach out of tmux session 
`tmux attach-session -t COIcontaminationBlast` to get back in.

Output = `BLASTResults_COIcontamination.txt`. 