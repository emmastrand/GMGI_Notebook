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
