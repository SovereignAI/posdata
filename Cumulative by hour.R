library(googlesheets4)
ball_count<- read_sheet("https://docs.google.com/spreadsheets/d/17XOdG71OU7sDT1PvT2_Ny_saipLvbh2u6w0mLhyXr5I/edit#gid=228679708")
ls(ball_count)
library(reshape2)  
library(ggplot2)

hour2_20<-read.csv("Downloads/2.20-23Hourly/Hour 2_20.csv")
hour2_21<-read.csv("Downloads/2.20-23Hourly/Hour 2_21.csv")
hour2_22<-read.csv("Downloads/2.20-23Hourly/Hour 2_22.csv")

newrow<-c("09AM",0)
hour2_20 <- rbind(hour2_20[1:8,],newrow,hour2_20[-(1:8),])
newrow<-c("08AM",0)
hour2_20 <- rbind(hour2_20[1:7,],newrow,hour2_20[-(1:7),])

newrow<-c("08PM",0)
hour2_22 <- rbind(hour2_22[1:8,],newrow,hour2_22[-(1:8),])
Tuesday <-hour2_21$Balls
Wednesday <- hour2_22$Balls

TimeofDay1<-format(as.POSIXct(hour2_22$category,format='%I %p'),format="2023-02-22 %H:%M")
TimeofDay2<-format(as.POSIXct(hour2_21$category,format='%I %p'),format="2023-02-21 %H:%M")
TimeofDay3<-format(as.POSIXct(hour2_20$category,format='%I %p'),format="2023-02-20 %H:%M")

hour2_20<-cbind(hour2_20,TimeofDay3)
hour2_20 <- subset(hour2_20, select = -c(category))
hour2_20<-hour2_20[order(TimeofDay),]

hour2_21<-cbind(hour2_21,TimeofDay2)
hour2_21 <- subset(hour2_21, select = -c(category))
hour2_21<-hour2_21[order(TimeofDay),]

hour2_22<-cbind(hour2_22,TimeofDay1)
hour2_22 <- subset(hour2_22, select = -c(category))
hour2_22<-hour2_22[order(TimeofDay),]

hour_data<- cbind (hour2_20, hour2_21)
hour_data<- cbind (hour_data, hour2_22)


library(tidyr)
hourdf <- data.frame(Monday=as.integer(hour2_20$Balls), Tuesday=hour2_21$Balls)


hourdf<-pivot_longer(hourdf, Monday:Tuesday)
4

ggplot(hour_data, aes(x=TimeofDay3,y=))

TimeofDay<-format(as.POSIXct(category,format='%I %p'),format="%H:%M")
hour_data<-cbind(hour_data,TimeofDay)
hourdata <- subset(hour_data, select = -c(category))
hourdata<-hourdata[order(TimeofDay),]
hourdata
ggplot(hourdata,aes(x=TimeofDay, y=cumsum(Monday))) +geom_point() 

attach(ball_count)
D20<-as.numeric(as.character(`Date (cmd+:)`))
M20 <- subset(ball_count,D20 == "2/20/2023")
Time<-as.character(`Time (cmd+shift+;)`)

Time

Time20<-M20$Time
ggplot(ball_count, aes(x=Time20, y=cumsum(`Approx. Balls`)))+geom_point()