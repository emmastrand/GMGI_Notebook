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

### Preparation 

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

1. Add 18 uL (to get total volume up to 20 uL with DNA below) of 10 mM Tris HCl (or Qiagen Buffer AE) or nuclease free water.  
2. For each sample add 10 ng (2 uL of 5ng/uL) of DNA into a 0.2 mL PCR strip tube.  
3. Add 130 uL of Lightning Conversion Reagent to each tube. Total volume should be 150 uL now.  
4. Vortex for 10 seconds and spin down tubes.  
5. Place tubes in thermocycler with the following PCR protocol:  
- 98C for 8 minutes  
- 54C for 1 hr  
- 4C hold 

Once the program is done, samples can be stored in a 4C fridge for up to 20 hours so this is a good overnight stopping place. 

Video example by the Putnam Lab: https://www.youtube.com/watch?v=4ar8d5NeSks&list=PLI8mZMNHcIVq9DFCOPksLhcch8UbJj4Pq&index=2 

### 02. Post-Conversion Column Cleanup

> Sodium bisulfite is a harsh chemical that needs to be cleaned out of the DNA. This is why the DNA is treated with a Desulphonation Buffer in this step.

6. Label 1 spin column and collection tube for each sample  
7. Add 600 μl of M-Binding Buffer to a Zymo-Spin™ IC Column in a Collection Tube.  
8. Add the entire (150 μl) bisulfite conversion reaction to their respective spin columns.  
9. Cap and invert the spin columns (with collection tube attached) 5-10 times to well mix.  
10. Centrifuge spin columns at 16,000 rcf for 30 seconds.  
11. Discard the flow-through from the Collection Tube.  
12. Add 100 μl of M-Wash Buffer to each spin column.  
13. Centrifuge spin columns at 16,000 rcf for 30 seconds and discard in waste container.    
14. Add 200 μl L-Desulphonation Buffer to the column and let stand at room temperature (20°C-30°C) for 15 minutes.  
15. During the above 15 minutes, warm the tube of DNA Elution Buffer in the thermomixer to 56°C.  
16. Label new 1.5mL tubes, 1 for each sample with the Extraction ID.  
17. After the incubation, centrifuge at 16,000 rcf for 30 seconds and discard the flow-through.  
18. Add 200 μl M-Wash Buffer to the column (Wash Step 1).  
19. Centrifuge spin columns at 16,000 rcf for 30 seconds.  
20. Add 200 μl M-Wash Buffer to the column (Wash Step 2).  
21. Centrifuge spin columns at 16,000 rcf for **2 minutes**.  
22. Transfer spin columns to their new labeled 1.5 mL tubes and discard flow through and collection tubes.    
23. Add 8 μl of **warmed** DNA Elution Buffer by dripping directly onto the filter of the spin columns.  
24. Incubate columns at room temp for **5 minutes**.  
25. Centrifuge at 16,000 rcf for 30 seconds to elute the bisulfite-converted DNA.  
26. Discard spin columns and keep 1.5mL tubes on ice.  
27. Check if all tubes have the same volume (greater elution volume may cause library prep failure). Make a note of any that have more than 8 μl. 

### 03. Amplification with PrepAmp Primer

> Here, the converted DNA is randomly primed with PCR primers that have degenerate bases so that amplification takes place all across the genome. Random priming and PCR of the fragmented DNA results in pieces of DNA 150-600bp long. The polymerase in this step is able to recognize Uracil and thus is more sensitive than other polymerases used in PCRs. This is why it needs to be added in twice, after the 98 degree step, because it would break down at that temperature.

**Preparation** 

Thaw needed reagents:  
- 5X PrepAmp Buffer  
- 40 uM PrepAmp Primer  
- PrepAmp Pre-mix  
- PrepAmp Polymerase  

Determine n number: number of samples + % error (~5%)

Create **Priming Master Mix (PMM)** on ice (Vortex and spin down PMM and keep on ice):  
- 2 μl 5X PrepAmp Buffer * n =  
- 1 μl 40uM PrepAmp Primer * n =  

Create **PrepAmp Master Mix (PAMM)** on ice (Vortex and spin down PAMM and keep on ice):  
- 1 μl 5X PrepAmp Buffer * n =  
- 3.75 μl PrepAmp Pre Mix * n =  
- 0.3 μl PrepAmp Polymerase * n =  

Create **"diluted" PrepAmp Polymerase mix** to avoid adding less than 0.5ul during protocol (original protocol asks you to add 0.3ul to the tubes in the thermocycler, sometimes that small of an amount does not come out of the tip so you can add DNA elution buffer to the enzyme to pipette 0.5ul). Make this on ice (Pipette mix and spin down the diluted polymerase and keep on ice):
- 0.3 μl PrepAmp Polymerase * n =  
- 0.2 μl DNA Elution Buffer * n =

Make new strip tubes for each one of your samples.

28. Add 7 μl of bisulfite converted sample to their respective strip tube. This should be about all the liquid there is in the final tubes from the previous cleanup.  
29. Add 3ul of **PMM** to each tube.  
30. Vortex tubes, spin them down, and place them in the thermocyler with the following program (2 cycles): 

Cycle 1: 
- 98C for 2 minutes    
- 8C for 1 minute   
- 8C hold   
- During hold, open the machine and take out the tubes (don't press a button yet!) vortex and spin the tubes down, add 5.05 µl **PAMM** to each tube, vortex and spin the tubes down again, and place back in thermocycler and press enter on the machine  
- 8C for 4 minutes  
- 16C for 1 minute with 3% ramp rate  
- 22C for 1 minute with 3% ramp rate  
- 28C for 1 minute with 3% ramp rate  
- 36C for 1 minute with 3% ramp rate  
- 36.5C for 1 minute with 3% ramp rate  
- 37C for 8 minutes  
- At the end of cycle 2: 4C hold 

Cycle 2: exact same as above but during hold, again open the machine and take out the tubes without pressing a button, vortex and spin them down, then add 0.5 µl of the **diluted PrepAmp Polymerase** to each tube then, vortex and spin them down again, and place back into thermocycler and press enter on the program. It should take 20ish minutes between the two holds in the program. 

31. When the program is done take out the tubes and place them on ice. 

### 04. Purification with the DNA Clean & Concentrator™ (DCC™)  

> This step removes leftover enzymes and buffers from the solution that would inhibit the next reaction.

32. Make new 1.5 mL tubes for each of your samples.  
33. Add 108.85 µl of DNA binding buffer to each of the new 1.5 mL tubes. This is a 7:1 ratio of the amount of liquid from the PrepAmp Priming reaction.  
34. Set the thermomixer to 56C and place the DNA Elution Buffer in to warm.  
35. Add the total volume of the strip tubes from the PrepAmp Priming reaction to their respective 1.5mL tube. This should be 15.55 µl but there may be less because the lid temperature on the theremocycler program is low and does not prevent evaporation.  
36. Vortex and spin down the 1.5 mL tubes to mix.  
37. Set up a spin column and a collection tube for each sample (same as before).  
38. Add the total volume of the 1.5 mL tube to their respective spin column.  
39. Centrifuge the spin columns at 16,000 rcf for 30 seconds.  
40. Discard the flowthough in the same waste beaker or container as above.  
41. Add 200 µl of DNA Wash Buffer to each spin column.  
42. Centrifuge the spin columns at 16,000 rcf for 30 seconds and discard the flow through.  
43. Add 200 µl of DNA Wash Buffer to each spin column

*left off here.* 



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
