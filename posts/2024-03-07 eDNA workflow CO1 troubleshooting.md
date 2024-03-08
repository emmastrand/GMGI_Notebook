# Environmental DNA (eDNA) metabarcoding with COI 

### Water collection 

1L of water was collected from the Gulf of Maine and filtered through a 0.2 uM filter 47 mm MCE filter (Sigma Aldrich Cat No. 1040-6970). 

### Lab steps 

DNA extracted from filter with the Qiagen DNeasy PowerSoil Pro Kit and quantified with Qubit dsDNA Broad Range assay kit. 

PCR1: Target amplication for invertebrates using COI region and Leray Geller primer set:  
- Leray Geller CO1 amplicon F: GGWACWGGWTGAACWGTWTAYCCYCC  
- Leray Geller CO1 amplicon R: TANACYTCNGGRTGNCCRAARAAYCA 

PCR1 reaction components for 25 uL reactions:  
- DNase/RNase free H2O (14.38 uL)  
- 10X Buffer (2.50 uL)  
- MgCl2 (2 uL)  
- dNTPs (0.5 uL)  
- 10 uM forward primer (1.25 uL)  
- 10 uM reverse primer (1.25 uL)  
- Taq enzyme (0.13 uL)  
- Sample DNA (3 uL)

Samples run in triplicate.

PCR1 cycling conditions:  

| COI Pair 1               | Step                 | Temperature and time                 | Number of cycle |
|--------------------------|----------------------|--------------------------------------|-----------------|
|                          | Initial denaturation | 95°C for 10 min                      | 1               |
| mlCOIintF (Geller et al) | Denaturation         | 95°C for 10 seconds                  | 16              |
| jgHCO2198 (Leray et al)  | Annealing            | 62°C (-1°C per cycle) for 30 seconds |                 |
|                          | Extension            | 72°C for 1 min                       |                 |
| "LERAYGEL"               | Denaturation         | 95°C for 10 seconds                  | 20              |
| on thermocycler          | Annealing            | 46°C for 30 seconds                  |                 |
|                          | Extension            | 72°C for 1 min                       |                 |
|                          | Final extension      | 72°C for 7 min                       | 1               |


Sequencing completed with Illumina MiSeq Reagent Nano Kit v2 (500-cycles) MS-103-1003.

### Bioinformatic steps 

Raw fastqc files were trimmed with CutAdapt to remove adapters (98% of reads passed filters). Quality filtered and ASV inference was conducted with DADA2 and between 32.8% and 79.86% reads per sample (average 56.3%) reads passed all DADA2 steps. The majority of ASV lengths were ~313 bp which is expected for this region of COI with Leray Geller primers.  

1,093 ASV groups detected and assigned taxonomy via Blast+ with the follow parameters (97% ID and 90% query cover): 

```
blastn -query ASV_seqs.fasta \
   -db /data/resources/databases/blastdb/nt \
   -out BLASTResults_COIcontamination99_v3.txt \
   -max_target_seqs 10 -perc_identity 97 -qcov_hsp_perc 90 \
   -outfmt "6  qseqid   sseqid   pident   length   mismatch gapopen  qstart   qend  sstart   send  evalue   bitscore staxid   sscinames   scomnames"
```

### Results 

146 groups were classified (7.5% of total ASVs).  

218,354 reads are unclassified (out of 280,171 reads total; 77.94%).  

Reads from ASVs from the same taxonomic ID (staxid) were combined and common names plotted below: 

![](https://github.com/emmastrand/GMGI_Notebook/raw/main/scripts/eDNA%20ampliseq%20test/COI/ASV_ID_files/figure-gfm/unnamed-chunk-4-1.png)


Top 5 unassigned ASVs (63% of all unassigned reads). All five ASV groups map to COI region sequences for invertebrates but with ~80% ID. 

| **ASV ID**                       | **Number of reads** |
|----------------------------------|---------------------|
| f782b5c934941bc568e67597233f762b | 92820               |
| 41c6c4e4b8ce8c1b6e5a6fda372db79c | 13099               |
| ac2a039ac3fc7780e8e3eb3e58374df1 | 11250               |
| 4e7b375554fd7ba631d9af95e2ccad5d | 8118                |
| c74fe75b309859664502215266b64bad | 7134                |

Blast results:

**f782b5c934941bc568e67597233f762b**: (313 bp long) -- 1/3 of total reads  
- *Neoitamus sp* COI region (flies) = score 189; 86% qcover; 79% ID  (multiple in top 10 hit) 
- *Hemiarma marina* mtDNA genome (cryptomonads; algae) = 92% qcover; 78% ID  
- *Cernosvitoviella minor* COI region (annelids) = 82% qcover; 78% ID  
- *Oligaphorura sp.* COI region (springtail; arthropods) = 94% qcover; 76% ID (multiple in top 10 hit)  
- *Dolichopodidae sp* COI region (flies) = 83% qcover; 78% ID  
- Other in top 10-15: *Ommatius sp* (insect), *Elater ferrugineus* (insect), *Asilidae sp* (flies)

**41c6c4e4b8ce8c1b6e5a6fda372db79c**: (313 bp long)  
- *Mycetophilidae sp* COI region (small flies) = 82% qcover; 80% ID   
- *Diploria labyrinthiformis* COI region (brain coral) = 78% qcover; 81% ID    
- *Favia fragum* COI region (stony coral) = 78% qcover; 80% ID (multiple in top 10 hits, e.g., *Favia gravida*, *Favia leptopphylla*)    
- *Mussismilia hispida* COI region (colonial coral) = 78% qcover; 80% ID  
- *Colpophyllia natans* mtDNA genome (stony coral) = 78% qcover; 80% ID (multiple hits)  
- *Diploria strigosa* COI region (brain coral) = 78% qcover; 80% ID  (and *Diploria labyrinthiformis*)  
- Other: *Hydnophora exesa* mtDNA genome (horn coral), *Echinophyllia aspera* (chalice coral)

**ac2a039ac3fc7780e8e3eb3e58374df1**: (313 bp long)
- *Phytophthora mekongensis* COI region (tuberous plant) = 95% qcover; 80% ID  
- *Phytophthora sp* COI region (fungus like organism; parasite to plants) = 95% qcover; 80% ID (20-30+ hits)
- *Mortierella verticillata* mtDNA genome (fungi) = 94% qcover; 80% ID 
- *Feldmannia irregularis* COI region (marine algae) = 98% qcover; 78% ID  
- *Ectocarpus siliculosus* COI region (brown algae) = 98% qcover; 78% ID  
- *Aglaophenia tubulifera* (hydrozoan; plumed sea fir) = 92% qcover; 79% ID

**4e7b375554fd7ba631d9af95e2ccad5d**: (313 bp long)  
- *Phytophthora sp* COI region (fungus like organism; parasite to plants) = (20-30+ hits)
- *Phaeocystis antarctica* COI region (algae) = 98-100% qcover; 91% ID
- *Pterocladiella capillaceae* COI region (red seaweed) = 95% qcover; 81% ID 
- *Pythium sp.* COI region (parasitic fungi) = 95% qcover; 80% ID

**c74fe75b309859664502215266b64bad** (313 bp long)  
- *Minutocellus polymorphus* COI region (marine nanodiatom)  = 97% qcover; 90% ID 
- *Dimeregramma acutum* COI region (small diatom) = 91% qcover; 83% ID
- *Nitzschia putrida* mtDNA genome (diatom) = 93% qcover; 82% ID  
- Others: *Pseudo-nitzschia delicatissima* (diatom), *Cyclostephanos tholiformise* (diatom)
