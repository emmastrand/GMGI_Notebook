# Zymo Pico Methyl Seq Kit Protocol 

Protocol for preparing libraries of bisulfite-converted DNA for Whole Genome Bisulfite Sequencing.

### Prerequisites 

High molecular weight, good quality DNA extracts. Example of our DNA extraction protocol found here: https://github.com/emmastrand/GMGI_Notebook/blob/main/posts/2023-08-24%20Qiagen%20DNeasy%20DNA%20Extraction%20Kit%20Protocol.md. 

Unique Dual Index Primer Design. Our protocol found here: https://github.com/emmastrand/GMGI_Notebook/blob/main/posts/2023-08-21_Constructing%20Index%20Primers.md. 

### Kit Information 

Pico Methyl-Seq Library Prep Kit (Zymo #D5456) found here: https://www.zymoresearch.com/products/pico-methyl-seq-library-prep-kit.  
Handbook for the above kit found here: https://files.zymoresearch.com/protocols/_d5455_d5456_picomethylseq.pdf. 

### Similar protocols 

- Schedl from Putnam lab: https://github.com/meschedl/MESPutnam_Open_Lab_Notebook/blob/master/_posts/2020-09-18-WGBS-PMS-protocol.md. A lot of helpful hints from Maggie are included in the protocol below. 

### Workflow 

![](https://raw.githubusercontent.com/meschedl/MESPutnam_Open_Lab_Notebook/master/images/PMS-workflow.png)

### Materials and Equipment 

- [Pico Methyl Seq Library Prep Kit](https://www.zymoresearch.com/products/pico-methyl-seq-library-prep-kit)  
- Thermocylers  
- Microcentrifuge tubes
- Ethanol
- Magnetic DNA binding beads
- Magnetic plate for 96 well plates
- Multichannel and regular micropipettes
- Filter pipette tips
- Broad range dsDNA Qubit assay and tubes for Qubit use
- TapeStation4200 or other fragment analyzer
- D5000 Tapestation Supplies
- UDI Index primers: see example spreadsheets from [Putnam Lab](https://github.com/Putnam-Lab/Lab_Management/blob/master/Lab_Resources/DNA_RNA-protocols/Indexes_and_Barcodes/UDI_Index_Primer_Pairs_for_Pico_WGBS.csv) and from [GMGI protocol](https://github.com/emmastrand/GMGI_Notebook/blob/main/posts/2023-08-21_Constructing%20Index%20Primers.md). 

## Protocol 

## Preparation 

Note about timing and planning this prep:
- Calculate how much DNA you're going to use before you start the prep, ideally for all samples, getting the volumes ready before you start  
- Plan how you will index your samples before starting the preps.     
- It can make things easier on you do the prep over 1.5 days: start the prep in the afternoon by doing the DNA dilution and bisulfite conversion. The BS converted DNA can be stable at 4 degrees C for 20 hours. So you can take it out of the thermocycler after the conversion program and store it in the fridge for the next day  
- It will probably take you the entire second day if you do 10 or more samples (including the QC).    
- While things are in the thermocycler, it can be helpful to start making the mixes for the next step and keep them on the ice bucket

### Reagent Preparation 

**DNA Wash Buffer**: Add 26 mL 95% ethanol to the 6 ml concentrate.  
**M-Wash Buffer**: Add 26 ml 95% ethanol to the 6 ml concentrate.  

### DNA Dilution 

First you dilute your extracted DNA to a total amount of 1 or 10ng. This kit takes a very low input of DNA. Previous usage of this kit in the Putnam Lab optimized the protocol to work with 10 ng and some alterations to the manufacturer's protocol. Dilute extracted DNA to appropriate concentration so 10ng of DNA can be used to start the protocol without pipetting below 1ul and the input volume is no more than 20ul. Use the same buffer that the extracted DNA is in (ex. 10mM Tris HCl). 

Putnam Lab video on how to do this: https://www.youtube.com/watch?v=byipduTsFmc&list=PLI8mZMNHcIVq9DFCOPksLhcch8UbJj4Pq&index=2. 

For this protocol, we are using 10 ng of input and **diluting to 5ng/uL** to then take 2 uL as input for the following bisulfite conversion step. Example worksheet found [here](https://docs.google.com/spreadsheets/d/1lWT0KRO5x9RFflYMF9Jnk5lsGCo0k3_A98ZsyKd4kks/edit#gid=1516006517). 

If we want 5 ng/uL in 40 uL total (200 ng in 20 uL): 
- DNA input = 200/Qubit value  
- Tris HCl (Buffer AE from Qiagen) = 40-DNA input 

I use 40 uL in the past so that my highest concentration DNA extractions don't result in pipetting less than 1 uL of DNA into the dilution. 

### 01. Bisulfite Conversion of Genomic DNA 

> This step bisulfite-treats the DNA. This fragments the DNA, makes it single stranded, and converts all non-methylated Cytosines into Uracils. This happens because you treat the DNA with sodium bisulfate, which through a chemical reaction de-aminates the Cytosines (removing the NH3 group) and turns them into Uracils (see image below). Methylated Cs stay as Cs. The DNA becomes single stranded because it no-longer pairs well with the opposite strand, Uracils are 1. usually only present in RNA, and 2. Thymine takes the place of them in DNA. T and A pair together, and C and G pair together.

![](https://raw.githubusercontent.com/meschedl/MESPutnam_Open_Lab_Notebook/master/images/Screen%20Shot%202021-04-25%20at%2011.25.48%20AM.png)

1. 

### 02. Post-Conversion Column Cleanup

> Sodium bisulfite is a harsh chemical that needs to be cleaned out of the DNA. This is why the DNA is treated with a Desulphonation Buffer in this step.

### 03. Amplification with PrepAmp Primer

> Here, the converted DNA is randomly primed with PCR primers that have degenerate bases so that amplification takes place all across the genome. Random priming and PCR of the fragmented DNA results in pieces of DNA 150-600bp long. The polymerase in this step is able to recognize Uracil and thus is more sensitive than other polymerases used in PCRs. This is why it needs to be added in twice, after the 98 degree step, because it would break down at that temperature.

### 04. Purification with the DNA Clean & Concentrator™ (DCC™)  

> This step removes leftover enzymes and buffers from the solution that would inhibit the next reaction.

### 05. 1st Amplification with LibraryAmp Primers  

> This step again amplifies the DNA and adds on the specific adapters that allow the DNA to anneal to the flow-cell during sequencing. It is also at this step that the Uracil is converted to Thymines (maybe, could be the previous step, Zymo is not transparent about the method).

### 06. Purification with the DNA Clean & Concentrator™ (DCC™)  

> This step removes leftover enzymes and buffers from the solution that would inhibit the next reaction.

### 07. 2nd Amplification with Index Primer

> Another amplification is needed to add the barcoded indexes to the DNA, which allows for multiple samples to be pooled together for sequencing.

### 08. 1X Bead Cleanup 

> This step removes leftover enzymes and buffers and any remaining primer from the solution. What is left is the purified libraries.

### 0.7 Validation and Quantification of Library

**Broad Range dsDNA Qubit Assay**: The libraries need to be quantified before sequencing, previous sequencing has shown that libraries with concentrations below 7ng/ul have not sequenced well and have been removed from the analysis. If you have a library with a low quant, it might be advantageous to re-do the library.

**Bioanalyzer**: The libraries also need to be visualized for accurate size determination. Libraries that are being sequenced together should all be about the same size distribution. Previous sequencing has also shown that a library noticeably a different size from the others sequenced poorly and was removed from the analysis. If you have a library with a strange size, it might be advantageous to re-do the library.
