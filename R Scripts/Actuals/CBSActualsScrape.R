#Scrape from cbssports

#Setup
library("XML")
library("stringr")
library("ggplot2")
library("plyr")
library("data.table")

statsCategory <- c('passing','rushing','receiving','kicking')
weeks <- (1:9)
season <- 2015
baseurl <- "http://www.cbssports.com/nfl/stats/leaders/live/all/"
url <- paste(baseurl, statsCategory,"/",rep(weeks ,each=length(statsCategory)),sep="")
#test <- readHTMLTable('http://www.cbssports.com/nfl/stats/leaders/live/all/kicking/week1')[[3]]

#Scrape
nflstats <- lapply(url,function(x) {data.table(readHTMLTable(x,stringsAsFactors=FALSE)[[3]])})

#Trim Data
for(i in 1:length(nflstats)){
nflstats[[i]] <- nflstats[[i]][2:nrow(nflstats[[i]])]
}

#Clean Data
qbNames <- c("pname","team","passComp","passAtt","passYds","passTds","passInt")
rbNames <- c("pname","team","rushAtt","rushYds","rushTds","fumbles")
wrNames <- c("pname","team","rec","recYds","recTds","fumbles")
kNames <- c("pname","team","fg","fgAtt","xp","xpAtt","points")
tblNames <- rep(list(qbNames,rbNames,wrNames,kNames),length(weeks))

for(i in 1:length(nflstats)){


           names(nflstats[[i]]) <- tblNames[[i]]
  nflstats[[i]][,week := rep(weeks,each=length(statsCategory))[i]]
  
}
for(j in 1:length(nflstats)){
  nflstats[[j]][,c("rank","player","pos") := tstrsplit(nflstats[[j]]$pname,"[[:punct:]]")] ## this is the right one
  
}
#Merge
nflactuals<- rbindlist(nflstats, use.names=TRUE, fill=TRUE)

nflactuals$pname <- NULL


#Save file
save(nflactuals, file = paste0(getwd(), "/Data/NFL-Actuals.RData"))
write.csv(nflactuals, file = paste0(getwd(), "/Data/NFL-Actuals.csv"), row.names=FALSE)

save(nflactuals, file = paste0(getwd(), "/Data/Historical Projections/NFL-Actuals-", season, ".RData"))
write.csv(nflactuals, file = paste0(getwd(), "/Data/Historical Projections/NFL-Actuals-", season, ".csv"), row.names=FALSE)
