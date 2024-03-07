# Environmental DNA (eDNA) metabarcoding with COI 

Metabarcoding 8 samples to test the Leray Geller COI primer set:  
- Leray Gellar CO1 amplicon F: GGWACWGGWTGAACWGTWTAYCCYCC  
- Leray Gellar CO1 amplicon R: TANACYTCNGGRTGNCCRAARAAYCA 

Raw fastqc files were trimmed with CutAdapt to remove adapters (98% of reads passed filters). Quality filtered and ASV interence was conducted with DADA2 and between 32.8% and 79.86% reads per sample (average 56.3%) reads passed all DADA2 steps. The majority of ASV lengths were ~313 bp which is expected for this region of COI with Leray Geller primers.  

1,093 ASV groups detected and assigned taxonomy via Blast+ with the follow parameters (97% ID and 90% query cover): 

```
blastn -query ASV_seqs.fasta \
   -db /data/resources/databases/blastdb/nt \
   -out BLASTResults_COIcontamination99_v3.txt \
   -max_target_seqs 10 -perc_identity 97 -qcov_hsp_perc 90 \
   -outfmt "6  qseqid   sseqid   pident   length   mismatch gapopen  qstart   qend  sstart   send  evalue   bitscore staxid   sscinames   scomnames"
```

146 groups were classified (7.5% of total ASVs).  

218,354 reads are unclassified (out of 280,171 reads total; 77.94%).  

Reads from ASVs from the same taxonomic ID (staxid) were combined and common names plotted below: 

![](https://github.com/emmastrand/GMGI_Notebook/raw/main/scripts/eDNA%20ampliseq%20test/COI/ASV_ID_files/figure-gfm/unnamed-chunk-4-1.png)
