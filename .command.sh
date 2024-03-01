#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(dada2))

errF = readRDS("1_1.err.rds")
errR = readRDS("1_2.err.rds")

filtFs <- sort(list.files("./filtered/", pattern = "_1.filt.fastq.gz", full.names = TRUE))
filtRs <- sort(list.files("./filtered/", pattern = "_2.filt.fastq.gz", full.names = TRUE))

#denoising
sink(file = "1.dada.log")
dadaFs <- dada(filtFs, err = errF, selfConsist = FALSE, priors = character(0), DETECT_SINGLETONS = FALSE, GAPLESS = TRUE, GAP_PENALTY = -8, GREEDY = TRUE, KDIST_CUTOFF = 0.42, MATCH = 5, MAX_CLUST = 0, MAX_CONSIST = 10, MIN_ABUNDANCE = 1, MIN_FOLD = 1, MIN_HAMMING = 1, MISMATCH = -4, OMEGA_A = 1e-40, OMEGA_C = 1e-40, OMEGA_P = 1e-4, PSEUDO_ABUNDANCE = Inf, PSEUDO_PREVALENCE = 2, SSE = 2, USE_KMERS = TRUE, USE_QUALS = TRUE, VECTORIZED_ALIGNMENT = TRUE,BAND_SIZE = 16, HOMOPOLYMER_GAP_PENALTY = NULL,pool = "pseudo", multithread = 6)
saveRDS(dadaFs, "1_1.dada.rds")
dadaRs <- dada(filtRs, err = errR, selfConsist = FALSE, priors = character(0), DETECT_SINGLETONS = FALSE, GAPLESS = TRUE, GAP_PENALTY = -8, GREEDY = TRUE, KDIST_CUTOFF = 0.42, MATCH = 5, MAX_CLUST = 0, MAX_CONSIST = 10, MIN_ABUNDANCE = 1, MIN_FOLD = 1, MIN_HAMMING = 1, MISMATCH = -4, OMEGA_A = 1e-40, OMEGA_C = 1e-40, OMEGA_P = 1e-4, PSEUDO_ABUNDANCE = Inf, PSEUDO_PREVALENCE = 2, SSE = 2, USE_KMERS = TRUE, USE_QUALS = TRUE, VECTORIZED_ALIGNMENT = TRUE,BAND_SIZE = 16, HOMOPOLYMER_GAP_PENALTY = NULL,pool = "pseudo", multithread = 6)
saveRDS(dadaRs, "1_2.dada.rds")
sink(file = NULL)

#make table
mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs, minOverlap = 106, maxMismatch = 0, returnRejects = FALSE, propagateCol = character(0), trimOverhang = TRUE, match = 1, mismatch = -64, gap = -64, homo_gap = NULL, endsfree = TRUE, vec = FALSE,_nf_config_d93b4945$_run_closure1$_closure2$_closure3@1cb849b2, verbose=TRUE)
saveRDS(mergers, "1.mergers.rds")
seqtab <- makeSequenceTable(mergers)
saveRDS(seqtab, "1.seqtab.rds")

write.table('dada	selfConsist = FALSE, priors = character(0), DETECT_SINGLETONS = FALSE, GAPLESS = TRUE, GAP_PENALTY = -8, GREEDY = TRUE, KDIST_CUTOFF = 0.42, MATCH = 5, MAX_CLUST = 0, MAX_CONSIST = 10, MIN_ABUNDANCE = 1, MIN_FOLD = 1, MIN_HAMMING = 1, MISMATCH = -4, OMEGA_A = 1e-40, OMEGA_C = 1e-40, OMEGA_P = 1e-4, PSEUDO_ABUNDANCE = Inf, PSEUDO_PREVALENCE = 2, SSE = 2, USE_KMERS = TRUE, USE_QUALS = TRUE, VECTORIZED_ALIGNMENT = TRUE,BAND_SIZE = 16, HOMOPOLYMER_GAP_PENALTY = NULL,pool = "pseudo"', file = "dada.args.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, na = '')
write.table('mergePairs	minOverlap = 106, maxMismatch = 0, returnRejects = FALSE, propagateCol = character(0), trimOverhang = TRUE, match = 1, mismatch = -64, gap = -64, homo_gap = NULL, endsfree = TRUE, vec = FALSE,_nf_config_d93b4945$_run_closure1$_closure2$_closure3@1cb849b2', file = "mergePairs.args.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, na = '')
writeLines(c("\"NFCORE_AMPLISEQ:AMPLISEQ:DADA2_DENOISING\":", paste0("    R: ", paste0(R.Version()[c("major","minor")], collapse = ".")),paste0("    dada2: ", packageVersion("dada2")) ), "versions.yml")
