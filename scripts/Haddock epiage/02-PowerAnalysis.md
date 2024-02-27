Conducting Power Analysis for Haddock Epigenetic Aging Project
================
Authors: Emma Strand; <emma.strand@gmgi.org>

# Conducting a power analysis to decide sample size

Information can also be found here:
<https://github.com/emmastrand/GMGI_Notebook/blob/main/posts/2023-08-09_PowerAnalysis.md>.

Tutorials followed:

- <https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html>  
- <https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html>

## Install and load pwrss R package

Bulus, M. (2023). pwrss: Statistical Power and Sample Size Calculation
Tools. R package version 0.3.1.
<https://CRAN.R-project.org/package=pwrss>

Bulus, M., & Polat, C. (in press). pwrss R paketi ile istatistiksel guc
analizi \[Statistical power analysis with pwrss R package\]. Ahi Evran
Universitesi Kirsehir Egitim Fakultesi Dergisi.
<https://osf.io/ua5fc/download/>

``` r
#install.packages("pwrss") ##commented once I downloaded this so it won't run every time 
#install.packages("pwr") ##commented once I downloaded this so it won't run every time 
library(pwrss)
```

    ## 
    ## Attaching package: 'pwrss'

    ## The following object is masked from 'package:stats':
    ## 
    ##     power.t.test

``` r
library(pwr)
```

I’m looking at two types of analysis here: Correlation and Linear
Regressions. Both quantify direction and strength of the relationship
between two numeric variables (otolith age and epigenetic age).  
- Correlation = how well the variables are linearly related. Has value
-1 to 1.  
- Linear regression = estimates parameters of a linear equation that can
be used to predict one variable based on another. Can address cause and
effect, use equation to predict value of one variable based on another,
equation to quantify relationship.

## Linear Regression

<https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html#3_Linear_Regression_(F_and_t_Tests)>  
<https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html>

Tests model fit: - Omnibus F test in multiple liner regression is used
to test whether R2 is greater than 0 (zero).  
- Hierarchial Linear Regression tests multiple factors within a
regression analysis.

We are expecting that these three variables explain 90% of the variance
in the outcome (R2=0.90 or r2 = 0.90 in the code). Based on this, what
is the minimum required sample size?

- `alpha` = significance level
- `r2` = R2 for a linear regression  
- `k` = number of variables
- `power` = power of the test (0.8 is minimum to be considered high
  power)

### Omnibus F test

<https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html#3_Linear_Regression_(F_and_t_Tests)>

``` r
pwrss.f.reg(r2 = 0.90, k = 2, power = 0.80, alpha = 0.001)
```

    ##  Linear Regression (F test) 
    ##  R-squared Deviation from 0 (zero) 
    ##  H0: r2 = 0 
    ##  HA: r2 > 0 
    ##  ------------------------------ 
    ##   Statistical power = 0.8 
    ##   n = 9 
    ##  ------------------------------ 
    ##  Numerator degrees of freedom = 2 
    ##  Denominator degrees of freedom = 5.948 
    ##  Non-centrality parameter = 80.536 
    ##  Type I error rate = 0.001 
    ##  Type II error rate = 0.2

### Hierarchial Linear Regression

<https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html#3_Linear_Regression_(F_and_t_Tests)>

- `m` = \# of factors added

``` r
pwrss.f.reg(r2 = 0.90, k = 5, m = 2, power = 0.80, alpha = 0.05)
```

    ##  Hierarchical Linear Regression (F test) 
    ##  R-squared Change 
    ##  H0: r2 = 0 
    ##  HA: r2 > 0 
    ##  ------------------------------ 
    ##   Statistical power = 0.8 
    ##   n = 8 
    ##  ------------------------------ 
    ##  Numerator degrees of freedom = 2 
    ##  Denominator degrees of freedom = 1.888 
    ##  Non-centrality parameter = 70.992 
    ##  Type I error rate = 0.05 
    ##  Type II error rate = 0.2

### General Linear Model

<https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html>

- `f2` = effect size where f2 = R2 / (1-R2)  
- `u` = numerator degrees of freedom; number of coefficients you’ll have
  in your model (minus the intercept)

Sample size (n) = v + u + 1 From below command = 5.948 + 2 + 1 = 8.948
~9 samples with power = 0.8 From below command = 6.592 + 2 + 1 = 9.5292
~10 samples with power = 0.9

``` r
pwr.f2.test(u = 2, f2 = 0.9/(1 - 0.9), sig.level = 0.001, power = 0.9)
```

    ## 
    ##      Multiple regression power calculation 
    ## 
    ##               u = 2
    ##               v = 6.592909
    ##              f2 = 9
    ##       sig.level = 0.001
    ##           power = 0.9

## Correlation Test

<https://cran.r-project.org/web/packages/pwrss/vignettes/examples.html#10_Correlation(s)_(z_Test)>

- `r` = expected correlation
- `r0` = value expected to be different from r  
- `alternative` = “not equal” indicates a two-sided test and “greater”
  indicates a one-sided test
- `alpha` = significance value

``` r
pwrss.z.corr(r = 0.2, r0 = 0,
             power = 0.90, alpha = 0.0001, 
             alternative = "not equal")
```

    ##  A Correlation against a Constant (z Test) 
    ##  H0: r = r0 
    ##  HA: r != r0 
    ##  ------------------------------ 
    ##   Statistical power = 0.9 
    ##   n = 654 
    ##  ------------------------------ 
    ##  Alternative = "not equal" 
    ##  Non-centrality parameter = 5.172 
    ##  Type I error rate = 0 
    ##  Type II error rate = 0.1

## Ending notes

With significance level \< 0.001 and power = 0.9, we need at least ten
samples in a linear regression and correlation. We’ll have way more than
this so this won’t be a worry.
