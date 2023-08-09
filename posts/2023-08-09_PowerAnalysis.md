# Conducting a Power Analysis to choose sample size 

Resources:  
- https://www.r-bloggers.com/2021/05/power-analysis-in-statistics-with-r/  
- https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html 

The goal of conducting a power analysis to determine the sample size required to detect an effect of a given size with a given degree of confidence.

Requirements (if we have three of the below, we can calculate the fourth): 
1. Sample size
2. Effect size
3. Significance level (default is 0.05)
4. Power of the test 

Base R Functions for different types of power analysis: https://www.r-bloggers.com/2021/05/power-analysis-in-statistics-with-r/    
- `pwr.2p.test` = two proportions equal n    
- `pwr.2p2n.test` = two proportions unequal n   
- `pwr.anova.test` = balanced one way anova  
- `pwr.chisq.test` = chi square test  
- `pwr.f2.test` = general linear model  
- `pwr.p.test` = proportion one sample  
- `pwr.r.test` = correlation  
- `pwr.t.test` = t-tests (one sample, 2 samples, paired)  
- `pwr.r.test` = t-test (two samples with unequal n)  

Additional R package with more in depth examples: https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html. Depending on the type of analysis you're conducting, there is a different function (similar to the above) to calculate power analysis components. I suggest exploring the above link as a good resource. 

Examples:  
- GMGI Epigenetic Aging Project: https://github.com/emmastrand/Epigenetic_aging/blob/main/scripts/02-PowerAnalysis.md 