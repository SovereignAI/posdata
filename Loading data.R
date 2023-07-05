#load the data
June <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 01 June BallsDispensedbyDayofMonth.csv")
July <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 02 July BallsDispensedbyDayofMonth.csv.csv")
August <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 03 August BallsDispensedbyDayofMonth.csv")
September <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 04 September BallsDispensedbyDayofMonth.csv.csv")
October <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 05 October BallsDispensedbyDayofMonth.csv.csv")
November <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 06 November BallsDispensedbyDayofMonth.csv")
December <- read.csv("Downloads/drive-download-20230601T193339Z-001/2022 07 December BallsDispensedbyDayofMonth.csv")
January <- read.csv("Downloads/1 January2023BallsDispensedbyDayofMonth.csv")
February <- read.csv("Downloads/February2023BallsDispensedbyDayofMonth.csv")
March <- read.csv("Downloads/3 March2023BallsDispensedbyDayofMonth.csv")
April <- read.csv("Downloads/drive-download-20230601T193339Z-001/4 AprilBallsDispensedbyDayofMonth.csv")
May <- read.csv("Downloads/5 May 2023BallsDispensedbyDayofMonth.csv")
June2023<-read.csv("Downloads/6 June fake 6_1_6_19.csv")

#change format 
June$day <- as.Date(paste("2022-06-", June$category, sep = ""))
July$day <- as.Date(paste("2022-07-", July$category, sep = ""))
August$day <- as.Date(paste("2022-08-", August$category, sep = ""))
September$day <- as.Date(paste("2022-09-", September$category, sep = ""))
October$day <- as.Date(paste("2022-10-", October$category, sep = ""))
November$day <- as.Date(paste("2022-11-", November$category, sep = ""))
December$day <- as.Date(paste("2022-12-", December$category, sep = ""))
January$day <- as.Date(paste("2023-01-", January$category, sep = ""))
February$day <- as.Date(paste("2023-02-", February$category, sep = ""))
March$day <- as.Date(paste("2023-03-", March$category, sep = ""))
April$day <- as.Date(paste("2023-04-", April$category, sep = ""))
May$day <- as.Date(paste("2023-05-", May$category, sep = ""))
June2023$day <- as.Date(paste("2023-06-", June2023$category, sep = ""))

# Combine the two data frames using rbind()
months<-rbind(January,February)
months<-rbind(months,March)
months<-rbind(months,June)
months<-rbind(months,July)
months<-rbind(months,August)
months<-rbind(months,September)
months<-rbind(months,October)
months<-rbind(months,November)
months<-rbind(months,December)
months<-rbind(months,April)
months<-rbind(months,May)
months<-rbind(months,June2023)

library(dplyr)
months <- months %>%
  arrange(day)
months

#load our pickin data
library(googlesheets4)
library(ggplot2)
library(tidyverse)
ball_count<- read_sheet("https://docs.google.com/spreadsheets/d/17XOdG71OU7sDT1PvT2_Ny_saipLvbh2u6w0mLhyXr5I/edit#gid=228679708")
ls(ball_count)
ball_count$Date <- as.POSIXct(ball_count$Date)
Collect <- data.frame(TotalBalls = ball_count$TotalBalls, Date = ball_count$Date)
Collect <- na.omit(Collect)
Collect$balls_picked <- Collect$TotalBalls
Collect <- subset(Collect, select = -c(TotalBalls))

# load missing days
Collect <- Collect %>%
  mutate(Date = as.Date(Date)) %>%
  complete(Date = seq.Date(as.Date("2022-06-27"), as.Date("2023-06-19"), by = "day")) %>%
  replace_na(list(balls_picked = 0))
tail(Collect)

#clean up their data 
months <- subset(months, select = -c(category))
months$balls_dispensed <- months$Balls
months <- subset(months, select = -c(Balls))

#missing data for dispensing
balls_dispensed <- months$balls_dispensed
months <- months %>%
  complete(day = seq.Date(min(months$day), as.Date("2023-06-19"), by = "day")) %>%
  replace_na(list(balls_dispensed = 0))

collect


#merge the two data sets 
Balldata<-cbind(Collect,months$balls_dispensed )

write.csv(Balldata,"Downloads/June26-June2020231DataforPGC.csv", row.names=FALSE)
