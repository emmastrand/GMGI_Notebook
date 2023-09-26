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
- UDI Index primers: see example spreadsheets from [Putnam Lab](https://github.com/Putnam-Lab/Lab_Management/blob/master/Lab_Resources/DNA_RNA-protocols/Indexes_and_Barcodes/UDI_Index_Primer_Pairs_for_Pico_WGBS.csv) and from [GMGI protocol](https://github.com/emmastrand/GMGI_Notebook/blob/main/posts/2023-08-21_Constructing%20Index%20Primers.md).     
- E. coli Non-Methylated Genomic DNA from [Zymo](https://www.zymoresearch.com/products/e-coli-non-methylated-genomic-dna)


## Protocol 

### Preparation 

Note about timing and planning this prep:
- Calculate how much DNA you're going to use before you start the prep, ideally for all samples, getting the volumes ready before you start  
- Plan how you will index your samples before starting the preps.     
- It can make things easier on you do the prep over 1.5 days: start the prep in the afternoon by doing the DNA dilution and bisulfite conversion. The BS converted DNA can be stable at 4°C for 20 hours. So you can take it out of the thermocycler after the conversion program and store it in the fridge for the next day  
- It will probably take you the entire second day if you do 10 or more samples (including the QC).    
- While things are in the thermocycler, it can be helpful to start making the mixes for the next step and keep them on the ice bucket

**Spike-in sample**: We're using E. coli Non-Methylated Genomic DNA from [Zymo](https://www.zymoresearch.com/products/e-coli-non-methylated-genomic-dna) at 5 ug/20 uL concentration. For each sample, use 0.5% of E. coli DNA (e.g., 10 ng DNA input + 0.5 ng E. coli sample). 5 ug/20 uL = 0.25 ug/uL = 250 ng/uL.      
- Dilution calculator: https://physiologyweb.com/calculators/dilution_calculator_mass_per_volume.html 

Original stock: 0.25 ug/uL = 250 ng/uL    
Dilution 1: 1.6 uL of 0.25 ug/uL stock + 38.4 uL of TE buffer (10 mM Tris-HCl, 1 mM EDTA, pH 8.0) = 40 uL of 10 ng/uL  
Dilution 2: 2 uL of 10 ng/uL Dilution 1 + 38 uL of TE buffer (10 mM Tris-HCl, 1 mM EDTA, pH 8.0) = 40 uL of 0.5 ng/uL 

I'll take 1 uL of Dilution 2 for 0.5 ng input. *Vortex these really well while making to ensure concentrations are as accurate as possible.* 

### Reagent Preparation 

**DNA Wash Buffer**: Add 26 mL 95% ethanol to the 6 ml concentrate.  
**M-Wash Buffer**: Add 26 ml 95% ethanol to the 6 ml concentrate.  

### DNA Dilution 

First you dilute your extracted DNA to a total input amount of 1 or 10ng (or higher like 20 ng). This kit takes a very low input of DNA. Previous usage of this kit in the Putnam Lab optimized the protocol to work with 10 ng and some alterations to the manufacturer's protocol. Dilute extracted DNA to appropriate concentration so 10ng of DNA can be used to start the protocol without pipetting below 1ul and the input volume is no more than 20ul. Use the same buffer that the extracted DNA is in (ex. 10mM Tris HCl).

Putnam Lab video on how to do this: https://www.youtube.com/watch?v=byipduTsFmc&list=PLI8mZMNHcIVq9DFCOPksLhcch8UbJj4Pq&index=2. 

For this protocol, we are using 10 ng of input and **diluting to 5ng/uL** to then take 2 uL as input for the following bisulfite conversion step. Example worksheet found [here](https://docs.google.com/spreadsheets/d/1lWT0KRO5x9RFflYMF9Jnk5lsGCo0k3_A98ZsyKd4kks/edit#gid=1516006517). 

If we want 5 ng/uL in 40 uL total (200 ng in 20 uL): 
- DNA input = 200/Qubit value  
- Tris HCl (Buffer AE from Qiagen) = 40-DNA input 

I use 40 uL in the past so that my highest concentration DNA extractions don't result in pipetting less than 1 uL of DNA into the dilution. 

If we want 10 ng/uL in 20 uL total (200 ng): 
- DNA input = 200/Qubit value   
- Tris HCl (Buffer AE from Qiagen) = 20-DNA input  

20 ng as input has also worked well for me (GMGI Epigenetic Aging Project). I would recommend moving forward with 20 ng.

### 01. Bisulfite Conversion of Genomic DNA 

> This step bisulfite-treats the DNA. This fragments the DNA, makes it single stranded, and converts all non-methylated Cytosines into Uracils. This happens because you treat the DNA with sodium bisulfate, which through a chemical reaction de-aminates the Cytosines (removing the NH3 group) and turns them into Uracils (see image below). Methylated Cs stay as Cs. The DNA becomes single stranded because it no-longer pairs well with the opposite strand, Uracils are 1. usually only present in RNA, and 2. Thymine takes the place of them in DNA. T and A pair together, and C and G pair together.

![](https://raw.githubusercontent.com/meschedl/MESPutnam_Open_Lab_Notebook/master/images/Screen%20Shot%202021-04-25%20at%2011.25.48%20AM.png)

1. Add 17 uL (to get total volume up to 20 uL with DNA below) of 10 mM Tris HCl (or Qiagen Buffer AE) or nuclease free water into 0.2 mL PCR strip tube.        
2. For each sample add 10 ng (2 uL of 5ng/uL) of DNA into 0.2 mL PCR strip tube.    
3. For each sample add 0.5 ng (1 uL of 0.5 ng/uL Dilution 2 tube) of E. coli DNA into 0.2 mL PCR strip tube.  
3. Add 130 uL of Lightning Conversion Reagent to each tube. Total volume should be 150 uL now.    
4. Vortex for 10 seconds and spin down tubes.    
5. Place tubes in thermocycler with the following PCR protocol:  

NAMED "PICO BC" ON THERMOCYCLER AT GMGI IN EPIAGE FOLDER (~1 hr) 

- 98°C for 8 minutes  
- 54°C for 1 hr  
- 4°C hold 

Once the program is done, samples can be stored in a 4°C fridge for up to 20 hours so this is a good overnight stopping place. 

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
17. Grab the reagents needed from Section 03. to start thawing.   
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

> Here, the converted DNA is randomly primed with PCR primers that have degenerate bases so that amplification takes place all across the genome. Random priming and PCR of the fragmented DNA results in pieces of DNA 150-600bp long. The polymerase in this step is able to recognize Uracil and thus is more sensitive than other polymerases used in PCRs. This is why it needs to be added in twice, after the 98°C step, because it would break down at that temperature.

**Preparation** 

Thaw needed reagents:  
- 5X PrepAmp Buffer  
- 40 uM PrepAmp Primer  
- PrepAmp Pre-mix  
- PrepAmp Polymerase  

Determine n number: number of samples + % error (~5%)

> I've had success using 5% error and also not using this extra buffer. The reagents in the kit should have extra in them, but we've had issues in the past with the 2X Library Amp Master Mix running out. Zymo does not sell this separately so be mindful with use of the materials stored at -20C.

Labeling scheme for tiny tubes: PMM = "A"; PAMM = "B"; dPAP = "C"; AMM = "D". 

Create **Priming Master Mix (PMM)** on ice (Vortex and spin down PMM and keep on ice):  
- 2 μl 5X PrepAmp Buffer * n =  
- 1 μl 40uM PrepAmp Primer * n =  

Create **PrepAmp Master Mix (PAMM)** on ice (Vortex and spin down PAMM and keep on ice):  
- 1 μl 5X PrepAmp Buffer * n =  
- 3.75 μl PrepAmp Pre Mix * n =  
- 0.3 μl PrepAmp Polymerase * n =  

Create **"diluted" PrepAmp Polymerase mix (dPAP)** to avoid adding less than 0.5ul during protocol (original protocol asks you to add 0.3ul to the tubes in the thermocycler, sometimes that small of an amount does not come out of the tip so you can add DNA elution buffer to the enzyme to pipette 0.5ul). Make this on ice (Pipette mix and spin down the diluted polymerase and keep on ice):
- 0.3 μl PrepAmp Polymerase * n =  
- 0.2 μl DNA Elution Buffer * n =

Make new strip tubes for each one of your samples.

28. Add 7 μl of bisulfite converted sample to their respective strip tube. This should be about all the liquid there is in the final tubes from the previous cleanup.  
29. Add 3ul of **PMM** to each tube.  
30. Vortex tubes, spin them down, and place them in the thermocyler with the following program (2 cycles): 

NAMED "PICO 1" ON THERMOCYCLER AT GMGI IN EPIAGE FOLDER (~1 hr)

- 98°C for 2 minutes  
- 8°C for 1 minute  
- 8°C hold    
**[cycle starts]**  
Cycle 1: During hold, open the machine and take out the tubes (don't press a button yet!) vortex and spin the tubes down, add 5.05 µl **PAMM** to each tube, vortex and spin the tubes down again, and place back in thermocycler and press enter on the machine  
Cycle 2: exact same as above but during hold, again open the machine and take out the tubes without pressing a button, vortex and spin them down, then add 0.5 µl of the **diluted PrepAmp Polymerase (dPAP)** to each tube then, vortex and spin them down again, and place back into thermocycler and press enter on the program. It should take 20ish minutes between the two holds in the program.  
- 8°C for 4 minutes  
- 16°C for 1 minute with 3% ramp rate (0.1°C s-1)  
- 22°C for 1 minute with 3% ramp rate (0.1°C s-1)  
- 28°C for 1 minute with 3% ramp rate (0.1°C s-1)  
- 36°C for 1 minute with 3% ramp rate (0.1°C s-1)  
- 36.5°C for 1 minute with 3% ramp rate (0.1°C s-1)  
- 37°C for 8 minutes  
**[cycle ends]**   
- At the end of cycle 2: 4°C hold  

31. When the program is done take out the tubes and place them on ice. 

### 04. Purification with the DNA Clean & Concentrator™ (DCC™)  

> This step removes leftover enzymes and buffers from the solution that would inhibit the next reaction.

Before starting this step, pull reagents for Section 05. out of the freezer to thaw. 

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
43. Add 200 µl of DNA Wash Buffer to each spin column.  
44. Centrifuge the spin columns at 16,000 rcf for **2 minutes**.  
45. Make new 1.5 mL tubes for each sample.  
46. Transfer spin column to new 1.5mL tube and discard the collection tube.  
47. Add 12 µl of warmed DNA elution buffer directly by dripping to each spin column.  
48. Incubate spin columns at room temp for 5 minutes.  
49. Centrifuge spin columns at 16,000 rcf for 30 seconds.  
50. Discard spin columns and keep elution tubes on ice.  

### 05. 1st Amplification with LibraryAmp Primers  

> This step again amplifies the DNA and adds on the specific adapters that allow the DNA to anneal to the flow-cell during sequencing. It is also at this step that the Uracil is converted to Thymines (maybe, could be the previous step, Zymo is not transparent about the method).

Thaw reagents needed on ice:
- (2X) Library Amp Master Mix  
- Library Amp Primers (10 uM)

51. Make new strip tubes for each of the samples.  

Make the 1st **Amplification Master Mix (AMM)** on ice. Vortex, spin down, and place AMM on ice:
- 12.5 µl Library Amp Mix (2X) * n =  
- 1 µl Library Amp Primers (10 uM) * n =  

52. Add 13.5 µl of **AMM** to each of the new strip tubes on ice.  
53. Add 11.5 µl of sample from the DCC elution to their respective strip tube.  
54. Vortex and spin down tubes.  
55. Place in the thermocycler and choose the program you need: 

NAMED "PICO 2" ON THERMOCYCLER AT GMGI IN EPIAGE FOLDER (~40 min)

- 94°C for 30 seconds  
8 cyles of:   
[start of cycle]
- 94°C for 30 seconds     
- 45°C for 30 seconds  
- 55°C for 30 seconds    
- 68°C for 1 minute   
[end of cycle]
- 68°C for 5 minutes  
- 4°C hold

Once the program is done take out the tubes and place on ice. 

### 06. Purification with the DNA Clean & Concentrator™ (DCC™)  

> This step removes leftover enzymes and buffers from the solution that would inhibit the next reaction.

56. Make new 1.5 mL tubes for each of your samples.  
57. Add 175 µl of DNA binding buffer to each of the new 1.5 mL tubes. This is a 7:1 ratio of the amount of liquid from the 1st Amplification reaction.  
58. Set the thermomixer to 56°C and place the DNA Elution Buffer in to warm.  
59. Add the total volume of the strip tubes from the PrepAmp Priming reaction to their respective 1.5 mL tube. This should be 25 µl.  
60. Vortex and spin down the 1.5 mL tubes to mix.  
61. Set up a spin column and a collection tube for each sample (same as before).  
62. Add the total volume of the 1.5 mL tube to their respective spin column.  
63. Centrifuge the spin columns at 16,000 rcf for 30 seconds.  
64. Discard the flowthough in the same waste beaker or container as above.  
65. Add 200 µl of DNA Wash Buffer to each spin column.  
66. Centrifuge the spin columns at 16,000 rcf for 30 seconds and discard the flow through.  
67. Add 200 µl of DNA Wash Buffer to each spin column.  
68. Centrifuge the spin columns at 16,000 rcf for 2 minutes.  
69. Make new 1.5 mL tubes for each sample.  
70. Transfer spin column to new 1.5 mL tube and discard the collection tube.  
71. Add 12.5 µl of warmed DNA elution buffer directly by dripping to each spin column.  
72. Incubate spin columns at room temp for 5 minutes.  
73. Centrifuge spin columns at 16,000 rcf for 30 seconds.  
74. Discard spin columns and keep elution tubes on ice. 

### 07. 2nd Amplification with Index Primer

> Another amplification is needed to add the barcoded indexes to the DNA, which allows for multiple samples to be pooled together for sequencing.

Thaw reagents needed on ice:  
- Library Amp Master Mix (2X) on ice. 
- Planned paired indexing primers for your samples (UDI)

75. Make new strip tubes for each of the samples.  
76. 10.5 µl of DNA from the above DCC step  
77. 12.5 µl of 2X Library Amp Master Mix.  
78. 2 µl of the combined i7 and i5 primer pair (Zymo-Seq UDI Primer).    
79. Vortex and spin down tubes after all components are added to each tube.  

> The above mixture ratios are from Zymo suggestions based on the concentrations of the Zymo Seq UDI Primer (Cat #D3096). The concentration is smaller so we need a larger volume of each. 

80. Incubate the mixture in a thermo cycler with the following program for a total of ten (10) amplification cycles: 

NAMED "PICO 3" ON THERMOCYCLER AT GMGI IN EPIAGE FOLDER (~40 min)

- 94°C for 30 seconds  
**[cycle starts]**
- 94°C for 30 seconds  
- 58°C for 30 seconds  
- 68°C for 1 min  
**[cycle end]**
- 68°C for 5 min  
- 4°C hold 

After starting program, pull beads out of the 4°C fridge to thaw for Section 08.  
After the program is done, place the samples on ice. 

### 08. 1X Bead Cleanup 

> This step removes leftover enzymes and buffers and any remaining primer from the solution. What is left is the purified libraries.

Take Line Biosciences PCR Clean DX beads out of the refrigerator ~30 minutes before use to get to room temperature. Swirl the bottle to mix the beads but don't vortex.

Make fresh 80% ethanol for the day, using 100% ethanol (in the flammable cabinet) and ultrapure water. 400 uL of 80% ethanol is required per sample. 

Locate the rotating shaker and magnetic plate. 

81. When beads are at room temp, add 25 µl (equal volume) of beads to each strip tube. Pipette slowly because the bead solution is very viscous. Pipette mix the bead-sample mix at least 10 times until homogeneously brown.  
82. Place the strip tubes on the rotating shaker, rotating at 200 rpm for 15 minutes.  
83. At the 15 minutes on the shaker, place the tubes on the magnet rack and wait until the liquid goes clear and the beads have gone to the magnet.    
84. Using a p200 pipette set to 45 µl, carefully remove the clear supernatant from each tube without disturbing the beads and discard in a waste trough.  
85. Add 200 µl of 80% ethanol to each tube.  
86. Remove the ethanol (200 µl) from each tube carefully, without disturbing the beads, and discard the liquid in the waste trough.  
87. Add another 200 µl of 80% ethanol to each tube.   
88. Remove the ethanol (200 µl) from each tube carefully, without disturbing the beads, and discard the liquid in the waste trough.  
89. Use a p20 set to 20 µl to remove any residual liquid in each tube.  
90. Let tubes air dry for ~1 more minute.  
91. Take the tubes off the magnet.  
92. Resuspend the beads in 15 µl of DNA elution buffer: Pipette directly onto the bead patch over and over until the beads go into solution.  
93. Place the tubes back on the shaker at 200rpm for 5 minutes.  
94. After the 5 minutes place the tubes back on the magnet plate and wait until the liquid goes clear and the beads are to the magnet.  
95. Make new strip tubes (final tubes) that are well labeled for your libraries (sample name, date, "lib" initials).  
96. Freeze at -20°C if not doing QC on the same day, if QCing next, place on ice. 

### 09. Validation and Quantification of Library

**Broad Range dsDNA Qubit Assay**: The libraries need to be quantified before sequencing, previous sequencing has shown that libraries with concentrations below 7ng/ul have not sequenced well and have been removed from the analysis. If you have a library with a low quant, it might be advantageous to re-do the library.

**Bioanalyzer**: The libraries also need to be visualized for accurate size determination. Libraries that are being sequenced together should all be about the same size distribution. Previous sequencing has also shown that a library noticeably a different size from the others sequenced poorly and was removed from the analysis. If you have a library with a strange size, it might be advantageous to re-do the library.
