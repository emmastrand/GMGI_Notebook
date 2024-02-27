## WGBS workflow 

Non-methylseq version that I used for the Haddock project prior to getting nextflow running on NU cluster. 


## 0. Genome Preparation 

This was originally done in nextflow nf-core/methylseq testing but I kept the output to use in future steps. Otherwise the following code will work for bisulfite treating the genome: 

```
module load Bismark/v0.24.2

genome_folder="/data/prj/Fisheries/epiage/haddock/"

bismark_genome_preparation \
--verbose \
--parallel 28 \
--bowtie2 \
${genome_folder}/OLKM01.fasta

```

## 1. Trim Galore! 

The `clip` parameters below were decided by running a subset of samples through TrimGalore, Nextflow, and Bismark to look at the m-bias reports. Clipping by 10 on each side will get rid of a decrease/increase in % methylation in the first and last 10 bp of the read b/c of sequencing not biological reasons. 

Start a new tmux session: `tmux new -s trimgalore_full`    
Start script: `bash trimgalore.sh`  
To go back into a session: `tmux attach-session -t trimgalore_full`   

`trimgalore.sh` 

```
#!/bin/bash

cd /data/prj/Fisheries/epiage/haddock/raw_data

module load fastQC/v0.12.1
module load multiQC/v1.16
module load trimgalore/v0.6.10

trim_galore \
    --output_dir full_trimmed/ \
    --fastqc   \
    --clip_r1 10 --clip_r2 10 \
    --three_prime_clip_r1 10 --three_prime_clip_r2 10 \
    --cores 4 \
    --paired \
    --gzip \
    --illumina \
    Mae-4*fastq.gz \
    Mae-5*fastq.gz
```

Output files: `*.fq.gz` with `val_1` or `val_2` are the final trimmed and validated reads. 

Information for using `--cores` with python3 and pigz: https://github.com/FelixKrueger/TrimGalore/pull/39. 

```
## from output of script running 
Parallel gzip (pigz) detected. Proceeding with multicore (de)compression using 4 cores

Proceeding with 'pigz -p 4' for decompression
```

Confirmed this is running as fast as it can on our RHEL system. 

Notes:  
- 12/4/23 this stopped running during Mae-368 b/c of server issues. Start back up with those files. Started with trying to finish all remaining 300s. Turns out this was re-doing all of the 300s, so a bit of a waste of time but the align scripts take forever so not a big deal in the end. 
- Mae-263 trimming was cut short for some reason.. Only 1/2 the number of files.. Will re-run trimming on that file. In tmux session `tmux attach-session -t trim263`. Successfully run.  
- 12/7/2023: run trimgalore! on all `Mae-4*fastq.gz` and `Mae-5*fastq.gz` in `trimgalore20231207s.sh`.


Write output of tmux session:

```
tmux display-message -p -F "#{history_limit}" -t trimgalore_full  
# 2000

tmux capture-pane -Jp -S -2000 -t trimgalore_full > trimgalore_full_20231205.txt
```


## 5. Bismark Align 

I'm running this in chunks b/c the bismark align takes awhile so I'm trying to optimize analysis time before a conference but this function can/should be run altogether. So as files were finished trimming, I could start the alignment for those samples. 

#### general notes 

Temporary files are stored in the directory where the bash script is run. For me this was in the scripts folder. Once the sampel finishes, the temporary files are removed by the program. 

- `-p`: threads per Bowtie2 instance. This runs 4 instances with 4 threads each = 16 threads total. The max instances is 8 with the ability to utilize more threads per instance (-p 12 will run 8 instances of 12 threads so 96 threads total). 

### example script 

I changed the input and -p every time I ran the below version. 

`bismark_align200s.sh`

starting new session: `tmux new -s bismark_align200s`  
attach session: `tmux attach-session -t bismark_align200s`  

```
#!/bin/bash

module load Bismark/v0.24.2
module load bwa/v0.7.17

out_dir="/data/prj/Fisheries/epiage/haddock/methylseq/full/bismark/align/"
genome_folder="/data/prj/Fisheries/epiage/haddock/methylseq/full/reference_genome/BismarkIndex/"
reads_dir="/data/prj/Fisheries/epiage/haddock/raw_data/full_trimmed/"

find ${reads_dir}/Mae-33*_R1_001_val_1.fq.gz \
| xargs basename -s _R1_001_val_1.fq.gz | xargs -I{} bismark \
--bowtie2 \
-genome ${genome_folder} \
-p 7 \
-score_min L,0,-0.6 \
--non_directional \
-1 ${reads_dir}{}_R1_001_val_1.fq.gz \
-2 ${reads_dir}{}_R2_001_val_2.fq.gz \
-o ${out_dir} 
```

Notes:  
- Started Friday 12/1 ~9:30 am and was cut off Sunday morning b/c of server issues. Restarted monday morning. Mae 278: 13 h 13 min 46s (last run to be running when server shut down so I'm not sure if I'm 100% confident in this..). Mae 274: 13h 5m 28s. Mae 266: 15h 20m 23s. Restarted Mae278 individually in `bismark_align200s`. Temp files get saved within the script directory b/c that is where the command started. So Mae278 is complete, but Mae263 and Mae281 were cut off. deleted temp files and started over. The times above were run on -p 8 threads so 64 threads total (128 threads on entire server). With 64 threads, each sample look ~13-15 hours. With 16 threads, each sample will take ~2.3 days/(~56 hrs). 
- Mae281 (`BA_281.sh`) started Monday 12/4 11 am (`tmux attach-session -t bismark_align200s`) -- Bismark completed in 1d 18h 47m 2s.    
- Run 290s (`BA_290s.sh`) 12/4 11:45 am (`tmux attach-session -t bismark_align290s`) with -p 4 so 4 instances of 4 threads (16 threads total): 293 finished, 294 running.      
- Mae-302 (`BA_302.sh`) 12/4 4:00 pm (`tmux attach-session -t bismark_align302`) with -p so 4 instances of 4 threads (16 threads total) -- Bismark completed in 1d 3h 33m 4s.    
- Mae-305 (`BA_305.sh`) 12/6 7:15 am with -p 5 so this completes earlier (`tmux attach-session -t BA_305`) 5 threads per 4 instances  = 20 threads total: Bismark completed in 1d 10h 50m 55s.   
- Mae-322 (`BA_322.sh`) 12/6 9:00 am with -p 4 (`tmux attach-session -t BA_322`) 4 threads per 4 instances so 16 threads total: Bismark completed in 1d 17h 49m 3s.   
- Mae-31* (`BA_310s.sh`) 12/8 9:30 am with -p 6 (`tmux attach-session -t BA_310s`) 6 threads per 4 instances so 24 threads total. Finished.  
- Mae-329 (`BA_329.sh`) 12/11 9:40 am pm with -p 4 (`tmux attach-session -t bismark_align329`) 4 threads per 4 instances so 16 threads total. Bismark completed in 1d 4h 23m 59s. 
- Mae-330s (`BA_330s.sh`) 12/11 9:30 am with -p 7 (`tmux attach-session -t BA_330s`) 7 threads per 4 instances so 28 threads total. Completed in 1 day 4-10 hr range.  
- Mae-327 (`BA_327.sh`) 12/12 3:40 pm with -p 4 (`tmux attach-session -t BA_327`) 4 threads per 4 isntances so 16 threads total. Bismark completed in 1d 1h 41m 25s.   
- Mae-263 (`BA_263.sh`) 12/12 4 pm with -p 4 (`tmux attach-session -t BA_263`) 4 threads per 4 isntances so 16 threads total. Bismark completed in 1d 13h 51m 12s.  
- Mae-285 (`BA_285.sh`) 12/14 9 am with -p 5 (`tmux attach-session -t BA_285`) 5 threads per 4 instances so 20 threads total.  Bismark completed in 1d 7h 6m 35s. 
- Mae-340s (`BA_340s.sh`) 12/14 9 am with -p7 (`tmux attach-session -t BA_340s`) 7 threads per 4 instances so 28 threads total.  
- Mae-350s (`BA_350s.sh`) 12/15 6 pm EST with -p 5 (`tmux attach-session -t BA_350s`) 5 threads per 4 instances so 20 threads total.   
- Mae-360s (`BA_360s.sh`) 12/19 6 pm EST with -p 5 (`tmux attach-session -t BA_360s`)  
- Mae-370s (`BA_370s.sh`) 12/19 6 pm EST with -p 5 (`tmux attach-session -t BA_370s`)

Running: 340s and 350s 

Write output files: 

```
tmux display-message -p -F "#{history_limit}" -t bismark_align290s  
# 2000

tmux capture-pane -Jp -S -2000 -t BA_285 > BA_285.txt
```


## 6. Bismark Deduplicate

The script `deduplicate_bismark` is supposed to remove alignments to the same position in the genome from the Bismark mapping output (both single and paired-end SAM/BAM files), which can arise by e.g. excessive PCR amplification. Sequences which align to the same genomic position but on different strands are scored individually. https://felixkrueger.github.io/Bismark/bismark/deduplication/. 

`tmux new -s bismark_deduplicate`    
`tmux attach-session -t bismark_deduplicate` (exited, less than 24 hrs)

Run command in tmux session instead of shell script.

```
module load Bismark/v0.24.2

cd /data/prj/Fisheries/epiage/haddock/methylseq/full/bismark/align/align_bam/to_be_processed/

deduplicate_bismark \
--bam \
--paired \
*.bam
```

`mv *deduplicated* ../../deduplicated/`

`tmux capture-pane -Jp -S -2000 -t bismark_deduplicate > bismark_deduplicate20231214.txt`

## 7. Bismark Methylation Extractor

`bismark_methylation_extractor` operates on Bismark result files and extracts the methylation call for every single C analysed. The position of every single C will be written out to a new output file, depending on its context (CpG, CHG or CHH), whereby methylated Cs will be labelled as forward reads (+), non-methylated Cs as reverse reads (-).

This script also produces a bismark report and summary file from the extracted methylation calls. (~12 hours per sample ish)

`bismark_methextractor.sh`

`tmux new -s bismark_methylation_extractor`   
`tmux attach-session -t bismark_methylation_extractor`

```
#!/bin/bash

module load Bismark/v0.24.2

#cd /data/prj/Fisheries/epiage/haddock/methylseq/full/bismark/deduplicated/to_be_extracted
cd /data/prj/Fisheries/epiage/haddock/methylseq/full/bismark/align/align_bam/to_be_processed/

bismark_methylation_extractor \ 
--bedGraph --paired --counts --scaffolds --report \
*deduplicated.bam

bismark2report .
bismark2summary .
```

`tmux capture-pane -Jp -S -2000 -t bismark_methylation_extractor > bismark_methylation_extractor.txt`

Move files to different folder:

`mv *cov.gz ../../cov_files` and `mv *bedGraph.gz ../../cov_files`


`tmux attach-session -t bismark_methylation_extractor2` (2nd run with to_be_processed)

#### parameters from nextflow used in above pipeline 

Not all possibilities below, see https://nf-co.re/methylseq/2.5.0/parameters for all options. Read through carefully before running on your own data.

`boolean` = TRUE or FALSE parameter.

- `--input`: (csv file) Path to comma-separated file containing information about the samples in the experiment.    
- `--outdir`: (folder) The output directory where the results will be saved. You have to use absolute paths to storage on Cloud infrastructure.    
- `--email`: (email address) Email address for completion summary.   
- `--multiqc_title`: (string) MultiQC report title. Printed as page header, used for filename if not otherwise specified.   
- `--fasta`: (.fasta file) Path to FASTA genome file.  
- `--save_reference`: (boolean) Save reference(s) to results directory.  
- `--aligner`: default is bismark so this is not included in my script.   
- `--clip_r1`: (numeric value) Trim bases from the 5' end of read 1 (or single-end reads).  
- `--clip_r2`: (numeric value) Trim bases from the 5' end of read 2 (paired-end only).    
- `--three_prime_clip_r1`: (numeric value) Trim bases from the 3' end of read 1 AFTER adapter/quality trimming.     
- `--three_prime_clip_r2`: (numeric value) Trim bases from the 3' end of read 2 AFTER adapter/quality trimming.  
- `--save_trimmed`: (boolean) Save trimmed reads to results directory.  
- `--skip_trimming`: (boolean) Skip the trimgalore! portion of the script. To be used if reads are already trimmed. 

Choosing the above cut-offs is based on the multiqc report. We want to reduce the amount of m-bias, make sure adapters are trimmed, and poor quality portions of sequenced are trimmed.

- `--cytosine_report`: (boolean) Output stranded cytosine report, following Bismark's bismark_methylation_extractor step.  
- `--non_directional`: (boolean) Run alignment against all four possible strands.  
- `--relax_mismatches`: (boolean) Turn on to relax stringency for alignment (set allowed penalty with --num_mismatches).    
- `--num_mismatches`: (numeric value) 0.6 will allow a penalty of bp * -0.6 - for 100bp reads (bismark default is 0.2). 

Haddock genome: "The sequenced individual, a wild caught specimen approximately 1.3 kg belonging to the North-East Artic haddock population, was sampled near the Lofoten Islands (N68.04 E13.41), outside of its spawning season (in July 2009)". Because this individual is from the North-East Artic population, and not the Gulf of Maine like these samples, I'm going to the set a relaxed stringency for alignment, which allows more mistmatches in the alignment.  

# Subset testing code (same as above, but for only a few samples)

## Running subsets first 

### Trimgalore subset

`trimgalore_subset.sh`. Done with the tmux session from subset (`tmux attach-session -t methylseq_subset`)

```
#!/bin/bash

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset/sym_links

module load fastQC/v0.12.1
module load multiQC/v1.16
module load trimgalore/v0.6.10

trim_galore \
    --output_dir ../trimmed/ \
    --fastqc   \
    --clip_r1 2 --clip_r2 2 \
    --three_prime_clip_r1 2 --three_prime_clip_r2 2 \
    --cores 10 \
    --paired \
    --gzip \
    --illumina \
      Mae-263_S1_R1_001.fastq.gz \
      Mae-263_S1_R2_001.fastq.gz \
      Mae-266_S2_R1_001.fastq.gz \
      Mae-266_S2_R2_001.fastq.gz \
      Mae-274_S3_R1_001.fastq.gz \
      Mae-274_S3_R2_001.fastq.gz \
      Mae-278_S4_R1_001.fastq.gz \
      Mae-278_S4_R2_001.fastq.gz \
      Mae-281_S5_R1_001.fastq.gz \
      Mae-281_S5_R2_001.fastq.gz
```

I made a new subset samples csv file and copied that to the server to use in the next step.

`scp /Users/EmmaStrand/MyProjects/Epigenetic_aging/data/metadata/samplesheet_subset_trimmed.csv estrand@192.168.4.5:/data/prj/Fisheries/epiage/haddock/`

### Subset used for testing 

I ran the below script on a subset of five samples before running this on all 70. This script takes a long time to run b/c the files are so large and I wanted to test a few values of trimming first.

Timeline (2 files per sample, R1,R2):    
- Prepare genome: 17 min     
- FastQC: 19-30 min per sample (multiple running at a time)       
- Bismark Align: 3-4 days per sample (multiple running at a time). 5 samples took THR-MON for me.    
- Samtools sort: 35-40 min per sample (multiple running at a time). 3 samples took ~45 min.       
- Bismark deduplicate: 45-60 min per sample (multiple running at a time). 3 samples took ~1 hr.  
- Bismark methylation extractor: Outside of nextflow so one at a time, 3 samples ~1.5 days.
- Bismark coverage2cytosine:  
- Bismark report:  
- Bismark summary:  
- Samtools sort deduplicate: 15-20 min per sample (multiple running at a time). 3 samples took ~20 min.  
- Qualimap:    
- Preseq:    
- Multiqc report: 

Start a new tmux session: `tmux new -s methylseq_subset2`  
Start script: `bash methylseq_subset.sh`
To go back into a session: `tmux attach-session -t methylseq_subset2`  

`methylseq_subset2.sh` (/data/prj/Fisheries/epiage/haddock/scripts)

```
#!/bin/bash

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset2

module load fastQC/v0.12.1
module load multiQC/v1.16
module load trimgalore/v0.6.10
module load cutadapt/v4.4
module load picard/v3.1.0
module load Bismark/v0.24.2
module load bwa/v0.7.17
module load nextflow/v23.04.4 ##try newest version first
module load qualimap/v2.3
module load preseq/v3.2.0

nextflow -log ./ run nf-core/methylseq -resume \
    --input ../../samplesheet_subset_trimmed.csv \
    --outdir ./ \
    --email emma.strand@gmgi.org \
    --multiqc_title haddockrun1 \
    --igenomes_ignore \
    --fasta ../../OLKM01.fasta \
    --save_reference \
    --skip_trimming \
    --cytosine_report \
    --non_directional \
    --relax_mismatches \
    --num_mismatches 0.6
```

To use Picard, you must call 'java -jar /data/resources/app_modules/picard-3.1.0/picard.jar ...'

#### create output file of tmux session 

Nextflow outputs a log file that will contain similar information but the below code outputs every command run in the tmux session.

```
tmux display-message -p -F "#{history_limit}" -t methylseq_subset2  
# 2000

tmux capture-pane -Jp -S -2000 -t methylseq_subset > methylseq_subset2_20231130.txt
tmux capture-pane -Jp -S -2000 -t bismark_align > bismark_align_20231129.txt
```

#### warning messages

```
task_id hash    native_id       name    status  exit    submit  duration        realtime        %cpu    peak_rss        peak_vmem       rchar   wchar
1       2f/2b1e46       193458  NFCORE_METHYLSEQ:METHYLSEQ:PREPARE_GENOME:BISMARK_GENOMEPREPARATION (BismarkIndex/OLKM01.fasta) COMPLETED       0       2023-11-23 11:09:52.229 17m 56s 17m 56s 195.8%  2.4 GB  2.7 GB  5.6 GB  2.9 GB
4       1c/9b830c       193482  NFCORE_METHYLSEQ:METHYLSEQ:FASTQC (Mae-274)     COMPLETED       0       2023-11-23 11:09:52.239 19m 52s 19m 19s 197.5%  2.1 GB  6.6 GB  14 GB   4.6 MB
5       30/056328       193438  NFCORE_METHYLSEQ:METHYLSEQ:FASTQC (Mae-278)     COMPLETED       0       2023-11-23 11:09:52.218 20m 27s 19m 25s 198.3%  2 GB    6.4 GB  13.6 GB 4.6 MB
2       d6/b8787e       193446  NFCORE_METHYLSEQ:METHYLSEQ:FASTQC (Mae-263)     COMPLETED       0       2023-11-23 11:09:52.224 24m 46s 23m 24s 196.8%  2.2 GB  6.6 GB  16.4 GB 4.7 MB
6       e9/05e0f4       193434  NFCORE_METHYLSEQ:METHYLSEQ:FASTQC (Mae-281)     COMPLETED       0       2023-11-23 11:09:52.209 26m 26s 23m 55s 198.0%  2.1 GB  6.6 GB  17.1 GB 4.6 MB
3       69/e0fa72       193467  NFCORE_METHYLSEQ:METHYLSEQ:FASTQC (Mae-266)     COMPLETED       0       2023-11-23 11:09:52.233 27m 1s  24m 9s  197.2%  2.1 GB  6.6 GB  17.2 GB 4.7 MB
10      d8/a148f1       253622  NFCORE_METHYLSEQ:METHYLSEQ:BISMARK:BISMARK_ALIGN (Mae-278)      FAILED  255     2023-11-23 11:27:48.671 2d 19h 21m 33s  2d 19h 21m 33s  -       -       -       -       -
9       02/f87dc9       253643  NFCORE_METHYLSEQ:METHYLSEQ:BISMARK:BISMARK_ALIGN (Mae-274)      COMPLETED       0       2023-11-23 11:27:48.684 2d 21h 54m 12s  2d 21h 54m 11s  768.2%  158.8 GB        244.6 GB        1.2 TB  956.4 GB
7       2a/6b4a9b       253617  NFCORE_METHYLSEQ:METHYLSEQ:BISMARK:BISMARK_ALIGN (Mae-263)      FAILED  255     2023-11-23 11:27:48.662 3d 4h 28m 45s   3d 4h 28m 45s   -       -       -       -       -
8       6d/45e0f2       253630  NFCORE_METHYLSEQ:METHYLSEQ:BISMARK:BISMARK_ALIGN (Mae-266)      COMPLETED       0       2023-11-23 11:27:48.677 3d 9h 38m 11s   3d 9h 38m 11s   728.6%  195.5 GB        291.5 GB        1.4 TB  1.1 TB
```

```
Caused by:
  Process `NFCORE_METHYLSEQ:METHYLSEQ:BISMARK:BISMARK_ALIGN (Mae-278)` terminated with an error exit status (255)

Command error:
  Chromosomal sequence could not be extracted for       A01204:198:HN5WMDSX7:4:2661:12726:32612_1:N:0:AAGTCCAA+TACTCATA ENA|OLKM01000485|OLKM01000485.1 296293
  Chromosomal sequence could not be extracted for       A01204:198:HN5WMDSX7:4:2664:25898:11397_1:N:0:AAGTCCAA+TACTCATA ENA|OLKM01002619|OLKM01002619.1 61154
```

This appears to be more of a warning not an error? https://github.com/FelixKrueger/Bismark/issues/303. 

"It does occur sometimes whenever reads map to the very edges of chromosomes, or scaffolds, and is generally nothing you need to be worried about (losing a handful of reads in a few hundred million is not really a deal breaker...).

You could also try to switch to the newer cow genome build (ARS-UCD1.2) and see if that is already better than the UMD3.1 build (as in, maybe shorter scaffolds have already been placed into chromosomes?)."

The root of the issue is caused by something in the genome and the latest Bismark update on 0.24.2 should have this error be a warning and not an exit. However, the 2 files that failed were not cached/kept... May have to run those outside of nextflow. I re-ran the script with the `-resume` flag for the other 3 samples to continue to deduplication and samtools sort steps. 


#### Bismark align 

Trying to run this outside of nextflow to see if this fixes the errors, I'm debating just ditching nextflow if I keep running into nf-core specific errors.

`bismark_align.sh`

starting new session: `tmux new -s bismark_align`  
attach session: `tmux attach-session -t bismark_align`  

```
#!/bin/bash

module load Bismark/v0.24.2
module load bwa/v0.7.17

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset

bismark \
    -1 trimmed/Mae-278_S4_R1_001_val_1.fq.gz -2 trimmed/Mae-278_S4_R2_001_val_2.fq.gz \
    --genome bismark/reference_genome/BismarkIndex \
    --bam \
    --bowtie2    --non_directional   --score_min L,0,-0.6  

```

#### Bismark Methylation Extractor

`bismark_methextractor.sh`

`tmux attach-session -t methylseq_subset`

This ran one file at a time so it took ~2.5 days for 3 files (samples). 

```
#!/bin/bash

module load Bismark/v0.24.2
module load bwa/v0.7.17

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset

bismark_methylation_extractor \ 
--bedGraph --counts --scaffolds --report \
bismark/deduplicated/*deduplicated.bam
```

Moved all output files to a new folder: `methylation_extracted` with `mv *deduplicated* methylation_extracted/`.  

### Bismark's coverage2cytosine 

The file output from the methylseq pipeline that is used for the following steps: `bismark_methylation_calls/methylation_coverage/*deduplicated.bismark.cov.gz`.

The Bismark coverage2cytosine command re-reads the genome-wide report and merges methylation evidence of both top and bottom strand to create one file.

Input: `*deduplicated.bismark.cov.gz`.
Output: `*merged_CpG_evidence.cov`.

`coverage2cytosine.sh`: 

starting new session: `tmux new -s coverage2cytosine`  
attach session: `tmux attach-session -t coverage2cytosine`  

```
#!/bin/bash

module load Bismark/v0.24.2

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset/bismark/methylation_extracted

find *deduplicated.bismark.cov.gz \
| xargs basename -s deduplicated.bismark.cov.gz \
| xargs -I{} coverage2cytosine \
--genome_folder ../reference_genome/BismarkIndex \
-o {} \
--merge_CpG \
--zero_based \
{}deduplicated.bismark.cov.gz
```

```
tmux display-message -p -F "#{history_limit}" -t coverage2cytosine  # 2000
tmux capture-pane -Jp -S -2000 -t coverage2cytosine > coverage2cytosine_20231130.txt
```

#### OVERVIEW

The script is saying:  
- for every file in methylation_coverage repo that ends with `deduplicated.bismark.cov.gz` (there should be 68 for this project),
and has basename of `_S0_L001_R1_001_val_1_bismark_bt2_pe.deduplicated.bismark.cov.gz` (everything that comes after the sample ID)  
- perform the function coverage2cytosine within the Bismark module.  
- identifies where the output genome is located (folder `reference_genome/BismarkIndex` within methylseq output folder)  
- `--zero_based`: uses 0-based genomic coordinates instead of 1-based coordinates. Default is OFF  
- `-o`: output file names; {} identifies these remain the same  
- `merge_CpG`: write out additional coverage files that has the top and bottom strand methylation evidence pooled into a single CpG dinucleotide entity.

Help on merge_CpG function: [FelixKrueger/Bismark#86](https://github.com/FelixKrueger/Bismark/issues/86).

Each CpG dinucleotide will have data for % methylation, and how many times that CpG was methylated or unmethylated.  

The output files will look like (without the headers):

[insert example]


## Sort CpG .cov file 

This function sorts all the merged files so that all scaffolds are in the same order. This needs to be done for multiIntersectBed to run correctly. This sets up a loop to do this for every sample (file). For every sample's `.cov` file in the output folder `merged_cov`, use bedtools function to sort and then output a file with the same name plus `_sorted.cov`.

Moving output files first `mv methylation_extracted/*merged_CpG_evidence.cov merged_cov/`. 

starting new session: `tmux new -s sort_bedtools`  
attach session: `tmux attach-session -t sort_bedtools`  

`sort_bedtools.sh`

```
#!/bin/bash

module load bedtools/v2.31.0

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset/bismark/merged_cov

for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  bedtools sort -i "${f}" \
  > "${STEM}"_sorted.cov
done
```

### Create bedgraphs of sorted files

Make an output directory for this. `mkdir merged_cov/bedgraphs`

starting new session: `tmux new -s create_bedgraphs`  
attach session: `tmux attach-session -t create_bedgraphs`  

`create_bedgraphs.sh`: 

```
#!/bin/bash

module load bedtools/v2.31.0

cd /data/prj/Fisheries/epiage/haddock/methylseq/subset/bismark/merged_cov

# Bedgraphs for 5X coverage 

for f in *_sorted.cov
do
  STEM=$(basename "${f}" _sorted.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 5) {print $1, $2, $3, $4}}' \
  > bedgraphs/"${STEM}"_5x_sorted.bedgraph
done

# Bedgraphs for 10X coverage 

for f in *_sorted.cov
do
  STEM=$(basename "${f}" _sorted.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 10) {print $1, $2, $3, $4}}' \
  > bedgraphs/"${STEM}"_10x_sorted.bedgraph
done
```

## Filter for a specific coverage (5X, 10X)

This script is running a loop to filter CpGs for a specified coverage and creating tab files.

Essentially, the loop in this script will take columns 5 (Methylated) and 6 (Unmethylated) positions and keeps that row if it is greater than or equal to 5. This means that we have 5x coverage for this position. This limits our interpretation to 0%, 20%, 40%, 60%, 80%, 100% methylation resolution per position.

Input File: `*merged_CpG_evidence.cov`
Output File: `5x_sorted.tab and 10x_sorted.tab`

starting new session: `tmux new -s filter_coverage`  
attach session: `tmux attach-session -t filter_coverage`  

`filter_coverage.sh`: 

```
#!/bin/bash
cd /data/prj/Fisheries/epiage/haddock/methylseq/subset/bismark/merged_cov

### Filtering for CpG for 5x coverage. To change the coverage, replace X with your desired coverage in ($5+6 >= X)

for f in *_sorted.cov
do
  STEM=$(basename "${f}" _sorted.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 5) {print $1, $2, $3, $4, $5, $6}}' \
  > "${STEM}"_5x_sorted.tab
done

### Filtering for CpG for 10x coverage. To change the coverage, replace X with your desired coverage in ($5+6 >= X)

for f in *_sorted.cov
do
  STEM=$(basename "${f}" _sorted.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 10) {print $1, $2, $3, $4, $5, $6}}' \
  > "${STEM}"_10x_sorted.tab
done
```

At this point all samples have the following files:  
- SampleID.CpG_report.txt  
- SampleID.CpG_report.merged_CpG_evidence.cov  
- SampleID_5x_sorted.tab  
- SampleID_10x_sorted.tab  

### 5X coverage 

`wc -l *5x_sorted.tab`

```
  13490303 Mae-266_S2_R1_001_val_1_bismark_bt2_pe._5x_sorted.tab
  11848303 Mae-274_S3_R1_001_val_1_bismark_bt2_pe._5x_sorted.tab
  12820322 Mae-281_S5_R1_001_val_1_bismark_bt2_pe._5x_sorted.tab
  38158928 total
```

~12,820,322 sites per sample.

### 10X coverage

`wc -l *10x_sorted.tab`

```
   8219855 Mae-266_S2_R1_001_val_1_bismark_bt2_pe._10x_sorted.tab
   6022777 Mae-274_S3_R1_001_val_1_bismark_bt2_pe._10x_sorted.tab
   7752300 Mae-281_S5_R1_001_val_1_bismark_bt2_pe._10x_sorted.tab
  21994932 total
```

~7,752,300 sites per sample.

Pausing to look at methylation % in R  