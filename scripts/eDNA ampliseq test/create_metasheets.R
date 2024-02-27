## Creating sample sheet for ampliseq 

library(dplyr)
library(stringr)

sample_list <- read.delim2("/work/gmgi/Fisheries/ampliseq_tutorial/sample_list.txt", header=F)

sample_list <- read.delim2("/Users/EmmaStrand/MyProjects/GMGI_Notebook/scripts/eDNA ampliseq test/sample_list.txt", header=F) %>% 
  dplyr::rename(forwardReads = V1) %>% 
  filter(!forwardReads == "sample_list.txt")

# creating sample ID 
sample_list$sampleID <- gsub("-", "_", sample_list$forwardReads)
sample_list$sampleID <- gsub("_R1.fastq.gz", "", sample_list$sampleID)
sample_list$sampleID <- paste("fish_", sample_list$sampleID, sep="")

# keeping only rows with R1
sample_list <- filter(sample_list, grepl("R1", forwardReads, ignore.case = TRUE))

# duplicating column 
sample_list$reverseReads <- sample_list$forwardReads

# replacing R1 with R2 in only one column 
sample_list$reverseReads <- gsub("R1", "R2", sample_list$reverseReads)

# rearranging columns 
sample_list <- sample_list[,c(2,1,3)]

# adding file path
sample_list$forwardReads <- paste("/work/gmgi/Fisheries/ampliseq_tutorial/",
                             sample_list$forwardReads, sep = "")
sample_list$reverseReads <- paste("/work/gmgi/Fisheries/ampliseq_tutorial/",
                                  sample_list$reverseReads, sep = "")

sample_list %>% write.csv("/work/gmgi/Fisheries/ampliseq_tutorial/metadata/samplesheet.csv", row.names=FALSE)