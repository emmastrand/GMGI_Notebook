# Fragment Analyzer Protocol 

Written for lab at GMGI. This SOP, for determining library size distribution using the Fragment Analyzer, is typically used for checking the final fragment size of shotgun-prepped sequencing libraries. 

## Materials 

Stored at Room Temperature:  
- Capillary Storage Solution (Agilent Cat# GP-440-0100)  
- 5x Capillary Conditioning Solution (Agilent Cat# DNF-475-0050)

Stored at 4°C:   
- NGS Fragment (1-6000bp) 500, 4C kit (Agilent Cat# DNF-473-0500)  
- 5x 930 dsDNA inlet Buffer (Agilent Cat# DNF-355-0125)  
- 0.25x TE Rinse Buffer (Agilent Cat# DNF-497-0125)  
- NGS Separation Gel (Agilent Cat# DNF-240-0240)    
- BF 2000 Blank Solution (Agilent Cat# DNF-302-0008)  

Stored at -20°C:  
- NGS Fragment (1-6000bp), FR (Agilent Cat# DNF-473-FR)  
- NGS Diluent Marker (1-6000bp) (Agilent Cat# DNF-374-0003)  
- NGS DNA Ladder (Agilent Cat# DNF-399-U100)  
- Intercalating Dye (Agilent Cat# DNF-600-U030)  

These kits can come in Standard Sensitivity or High Sensitivity kits from Agilent: https://www.agilent.com/en/product/automated-electrophoresis/fragment-analyzer-systems/fragment-analyzer-systems-dna-analysis-kits/small-fragment-ngs-kits-365701 

Advanced Analytical Fragment Analyzer: https://www.agilent.com/en/product/automated-electrophoresis/fragment-analyzer-systems/fragment-analyzer-systems/5200-fragment-analyzer-system-365720 

## Sample Preparation 

This kit requires 2 uL of sample, but the high sensitivity kit requires sampled to be diluted prior to use. At GMGI, we found that 1:10 dilution usually works well for this even though this is higher than the manual suggestion of 5-500 ng input. 

The fragment analyzer needs to use gel for 48 samples worth even if there are only 10 DNA samples you need to analyze. The remaining wells will be filled with blank solution if not all wells are filled with DNA samples. 

## Procedure

1. Thaw materials stored at -20°C on ice (~30 min).  
2. Check solutions in the right door (open in the image below):   
- ≥20 mL of 1X Capillary Conditioning Solution. This stock comes in 5X concentration so dilute as needed.  
- "Gel1" is used gel solution. No action required.    
- "Gel2" is new gel solution made in subsequent steps. Empty this 50 mL falcon tube if there is any remaining.  
3. Mix fresh Intercalating dye (kept at -20°C) and NGS Separation Gel (kept at 4°C) in a 50 mL falcon tube. Either 25 mL or 18 mL solutions will be enough for the analyzer.  
- 2.5 ul dye + 25 mL gel for 48 samples    
- 1.8 ul dye + 18 mL gel for 48 samples    
- 3.6 ul dye + 36 mL gel for 96 samples  
4. Place falcon tube in the "Gel 2" location on the Fragment Analyzer (FA), behind the right door (open in the image below).   
5. Dilute 5X 930 dsDNA Inlet Buffer to 1X. Fill all wells in rows A-D of a deep well plate with 1X Inlet Buffer and place it in the Drawer "B" on the FA. At GMGI we re-use this plate so double check the plate is full and in Drawer "B".  
6. Fill all wells in rows A-D of a semi-skirted 0.2 mL PCR plate with 200 ul 0.25X TE Rinse Buffer. Place in Drawer "M". At GMGI we re-use this plate so double check the plate is full and in Drawer "M".  
7. Mix 2 ul samples/ladder with 22 ul NGS diluent marker in a semi-skirted PCR plate. Ladder (kept at -20°C) must go in well D12 (H12 if running lower half of plate). Add 24 ul BF 2000 Blank solution (kept at -20°C) to unused wells. Place the plate in Drawer "1". It's encouraged to use 2 ladders in case 1 fails.  
8. Turn on the Fragment Analyzer. Switch is located in the back bottom center of the machine.  
9. Open Fragment Analyzer software. The machine should automatically "park" the plates but this may need to be done prior running a program.   
10. If bottles were refilled, at the top menu bar, select "Utilities" -> "Solution Levels" and adjust the solution levels as necessary.  
11. Select tray and Group to run (typically Tray 1, A-D for 48).  
12. Enter sample ID/tray ID (optional).  
13. Under "Run Selected Group", Select Add to Queue.  
14. Select "DNF-473-33 - SS NGS Fragment 1-6000 bp" from method dropdown menu. (or HS option).  
15. Change "Gel 1" to "Gel 2".  
16. Select OK to add method to queue.  
17. Start run (green arrow button) 
18. Open results in ProSize software. 
19. It may be necessary to adjust Upper Marker (UM) or Lower Marker (LM) peaks: It may be necessary to adjust Upper Marker (UM) or Lower Marker (LM) peaks.  
20. Save results as a PDF.  

![](https://www.biolabtech.com.ua/media/shop/images/f63e20a0-7d73-11ea-92b7-a2df97e5de28.JPG)