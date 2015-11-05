##DRAFT

########################
# File: ScrapeActuals.R
# Description: Scrapes actual points data from NFL.com
# Date: 10/19/2015
# Author: Brendan Lyons (brendan.lyons@gmail.com)
# Notes:
# To do:
###########################
#SetWd
setwd("/home/doondog/Dropbox/FantasyFootballAnalyticsR")

#Load libraries
library("XML")

###Load Functions
source(paste(getwd(),"/R Scripts/Functions/Functions.R", sep=""))
source(paste(getwd(),"/R Scripts/Functions/League Settings.R", sep=""))

#Declare Variables
urla <- "http://www.nfl.com/stats/weeklyleaders?week="
urlb <- "&season="
urlc <- "&type=REG&showCategory="
week <- (1:8) #Week of the season you want to import through
season <-2015 #season you want to evaluate
statscategory <- c('Passing','Rushing','Receiving','Placekick','Defensive','Punting')
nflurl <- paste0(urla,week,urlb,season,urlc,rep(statscategory,length(week)),sep="")


RecStats<- lapply(nflurl, function(x) {data.table(readHTMLTable(x,stringsAsFactors = FALSE)[[1]])})
#                   
# names(RecStats) <- c("Name","Team","Opponent","GameScore","Recs","Yds","Avg","TDs","Fum")
# RecStats$week <- as.factor(week)