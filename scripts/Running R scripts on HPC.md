# Running R scripts within HPC 

Some commands in R will be more efficient running on our server.  
`R` will automatically start the program running.  

Adding files to RHEL. 

`scp /Users/EmmaStrand/MyProjects/Epigenetic_aging/data/metadata/full_finclips_sampling.xlsx estrand@192.168.4.5:/data/prj/Fisheries/epiage/haddock/metadata/full_finclips_sampling.xlsx`

## 08. Datatable preparation

`08-Datatable preparation.R` is called in the below commands.  

`scp /Users/EmmaStrand/MyProjects/Epigenetic_aging/scripts/08-Datatable_preparation.R scp estrand@192.168.4.5:/data/prj/Fisheries/epiage/haddock/scripts/`

`tmux new -s datatable_prep`    
`tmux attach-session -t datatable_prep`  

```
cd /data/prj/Fisheries/epiage/haddock
R
source("~/../../data/prj/Fisheries/epiage/haddock/scripts/08-Datatable_preparation_RHEL.R")
```

scp estrand@192.168.4.5:/data/prj/Fisheries/epiage/haddock/df_all_20231220.RData /Users/EmmaStrand/MyProjects/Epigenetic_aging/data/WGBS/df_all_20231220.RData


## 09. Bayesian General Linear Model

`09-GLM.R` is called in the below script. 

`tmux new -s GLM`     
`tmux attach-session -t GLM`  

```
cd /data/prj/Fisheries/epiage/haddock
R
source("/data/prj/Fisheries/epiage/haddock/scripts/09-GLM_pruning.R")
```

Warning: There were 94 divergent transitions after warmup. See
https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
to find out why this is a problem and how to eliminate them.
Warning: Examine the pairs() plot to diagnose sampling problems

Warning: Bulk Effective Samples Size (ESS) is too low, indicating posterior means and medians may be unreliable.
Running the chains for more iterations may help. See
https://mc-stan.org/misc/warnings.html#bulk-ess
Warning: Tail Effective Samples Size (ESS) is too low, indicating posterior variances and tail quantiles may be unreliable.
Running the chains for more iterations may help. See
https://mc-stan.org/misc/warnings.html#tail-ess
Warning in (function (object, at, cov.reduce = mean, cov.keep = get_emm_option("cov.keep"),  :
  There are unevaluated constants in the response formula
Auto-detection of the response transformation may be incorrect
Warning in (function (object, at, cov.reduce = mean, cov.keep = get_emm_option("cov.keep"),  :
  There are unevaluated constants in the response formula
Auto-detection of the response transformation may be incorrect


20231226 notes:   
- Why do some sites have multiple outputs for bayesian statistics? All sites were run through GLM b/c GLM_Stats has single row per site, but _jt has some repeating rows? Use 308 sites output for now. From 1,277 rows that passed bayesian convergence and p-value below 0.05 from bayesian output. Prior to GLM bayesian model, sites were filtered out if contained no variance among samples or were 80% correlated with another site. Re-visit these filtering steps. We can't put too many sites as the input for the elastic net regression models or the GLMs. WGBS produces so much data, we may want to up the coverage to 15X or 20X even... re-visit after SICB. 