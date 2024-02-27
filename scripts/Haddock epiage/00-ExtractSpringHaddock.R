setwd("C:/Users/TimO'Donnell/Documents/R.directory/NEFSCTrawlData")
# To download original data files, use ftp in filezilla. Enter 
# ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22561 into the Host Box for 
# spring data. Enter ftp.nefsc.noaa.gov/pub/dropoff/PARR/PEMAD/ESB/22560 into the Host Box 
# for fall data. 


#Pull in all the Fall Cruise Data
# FallCruises<-read.csv("22560_FSCSTables/22560_SVDBS_CRUISES.csv")
# FallSVBio<-read.csv("22560_FSCSTables/22560_UNION_FSCS_SVBIO.csv")
# FallSVCAT<-read.csv("22560_FSCSTables/22560_UNION_FSCS_SVCAT.csv")
# FallSVLen<-read.csv("22560_FSCSTables/22560_UNION_FSCS_SVLen.csv")
# FallSVSta<-read.csv("22560_FSCSTables/22560_UNION_FSCS_SVSTA.csv")

#Pull in all the Spring Cruise Data
SpringSVLen<-read.csv("22561_FSCSTables/22561_UNION_FSCS_SVLen.csv")

#Sample only Haddock
#FallHaddockAllYears<-FallSVLen[FallSVLen$SVSPP=="074",]
SpringHaddockAllYears<-SpringSVLen[SpringSVLen$SVSPP=="074",]

Spring2021Haddock<-SpringHaddockAllYears[SpringHaddockAllYears$CRUISE6=="202102",]
Spring2021Haddock$ID<-as.character(Spring2021Haddock$ID)
#write.csv(FallHaddockAllYears, file="FallAllHaddock.csv")
write.csv(Spring2021Haddock, file="Spring2021Haddock.csv", row.names=FALSE)

#Count stations that caught haddock
#FallStationsWHaddock<-aggregate(STATION~CRUISE6, FallHaddockAllYears, function(x) length(unique(x)))
SpringStationsWHaddock<-aggregate(STATION~CRUISE6, SpringHaddockAllYears, function(x) length(unique(x)))






