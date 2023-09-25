# eDNA samples: testing primers for invertebrate targets

Our goal is to find a primer set that amplifies all of our target invertebrate species in the Offshore Wind project area. These include key commercial species such as lobster, jonah crab, urchin, soft shell clams, scallops, squid. We're testing different regions of COI and 18S (example images below).

![](https://github.com/emmastrand/GMGI_Notebook/blob/main/images/invert%20primer%20COI.png?raw=true)

![](https://github.com/emmastrand/GMGI_Notebook/blob/main/images/invert%20primer%20COI%2018S.png?raw=true)

## Primer ordering

GMGI addition to primers: 

- NexteraTrans1 (Forward): TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG

- NexteraTrans2 (Reverse): GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG

mtCOLintF_illumina and HCO2198_Illumina are primers we already have in lab and were not ordered from IDT.

### primer sequences ordered

| Fragment | Name               | Reference                 | Direction | Region sequence            | GMGI addition                      | Primer sequence   to order from IDT (GMGI + region)          |
|----------|--------------------|---------------------------|-----------|----------------------------|------------------------------------|--------------------------------------------------------------|
| COI      | jgHCO2198_Illumina | Leray et al., 2013        | R         | TAIACYTCIGGRTGICCRAARAAYCA | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGTAIACYTCIGGRTGICCRAARAAYCA |
| COI      | HCO2198_Illumina   | Folmer 1994               | R         | TAAACTTCAGGGTGACCAAAAAATCA | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGTAAACTTCAGGGTGACCAAAAAATCA |
| COI      | mlCOIintF_Illumina | Geller at al 2013         | F         | GGWACWGGWTGAACWGTWTAYCCYCC | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGGGWACWGGWTGAACWGTWTAYCCYCC  |
| COI      | LCO1490_Illumina   | Folmer 1994               | F         | GGTCAACAAATCATAAAGATATTGG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGGGTCAACAAATCATAAAGATATTGG   |
| COI      | ill_C_R            | Shokralla et al.,   2015  | R         | GGIGGRTAIACIGTTCAICC       | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGGGIGGRTAIACIGTTCAICC       |
| COI      | BF1                | Elbrecht et al., 2017     | F         | ACWGGWTGRACWGTNTAYCC       | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGACWGGWTGRACWGTNTAYCC        |
| COI      | BF2                | Elbrecht et al., 2017     | F         | GCHCCHGAYATRGCHTTYCC       | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGGCHCCHGAYATRGCHTTYCC        |
| COI      | BR1                | Elbrecht et al., 2017     | R         | ARYATDGTRATDGCHCCDGC       | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGARYATDGTRATDGCHCCDGC       |
| COI      | BR2                | Elbrecht et al., 2017     | R         | TCDGGRTGNCCRAARAAYCA       | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGTCDGGRTGNCCRAARAAYCA       |
| 18S      | TAReuk454FWD1      | Stoeck et al.,., 2010     | F         | CCAGCASCYGCGGTAATTCC       | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGCCAGCASCYGCGGTAATTCC        |
| 18S      | TAReukREV3r        | Stoeck et al.,., 2010     | R         | ACTTTCGTTCTTGATYRA         | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGACTTTCGTTCTTGATYRA         |
| 18S      | F‐574              | Hadziavdic et al.,   2014 | F         | GCGGTAATTCCAGCTCCAA        | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG  | TCGTCGGCAGCGTCAGATGTGTATAAGAGACAGGCGGTAATTCCAGCTCCAA         |
| 18S      | R‐952              | Hadziavdic et al.,   2014 | R         | TTGGCAAATGCTTTCGC          | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG | GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAGTTGGCAAATGCTTTCGC          |

### sets to test in lab

| Fragment | Direction | Name          | Reference               | Direction | Name        | Reference               | GMGI name         |
|----------|-----------|---------------|-------------------------|-----------|-------------|-------------------------|-------------------|
| 18S      | F         | TAReuk454FWD1 | Stoeck et al.,., 2010   | R         | TAReukREV3r | Stoeck et al.,., 2010   | Invert 18S Stoeck |
| 18S      | F         | F‐574         | Hadziavdic et al., 2014 | R         | R‐952       | Hadziavdic et al., 2014 | Invert 18S Hadz   |
| COI      | F         | mlCOIintF     | Geller at al 2013       | R         | jgHCO2198   | Leray et al., 2013      | Invert COI 1      |
| COI      | F         | LCO1490       | Folmer 1994             | R         | ill_C_R     | Shokralla et al., 2015  | Invert COI 2      |
| COI      | F         | BF1           | Elbrecht et al 2017     | R         | BR1         | Elbrecht et al 2017     | Invert COI 3      |
| COI      | F         | BF2           | Elbrecht et al 2017     | R         | BR2         | Elbrecht et al 2017     | Invert COI 4      |

## Insilico Testing

I downloaded the [Snap Gene](https://www.snapgene.com/) software to test insilico if the primers we chose would align with the COI and 18S region of our target species. I searched the scientific name of each target species with the name of the region (18S or COI) in [Blast](https://blast.ncbi.nlm.nih.gov/Blast.cgi) and added this FASTA sequence as a DNA region in the Snap Gene software application. Within Snap Gene, I then added each forward and reverse primer. If the primer aligned, this appeared in purple (see image below) along the white text DNA sequence of the target species. Screenshots of all are below.