library(googlesheets4)
ball_count<- read_sheet("https://docs.google.com/spreadsheets/d/17XOdG71OU7sDT1PvT2_Ny_saipLvbh2u6w0mLhyXr5I/edit#gid=228679708")
ls(ball_count)
library(reshape2)  
library(ggplot2)

latestweek <- subset(ball_count, Week == "19")


ggplot(ball_count, aes(x = Day, y = TotalBalls)) +geom_boxplot()+geom_point(data=latestweek, colour="red") + ggtitle("Daily Ball count", subtitle = "Last Week is shown in red") ## Box plot of the ball count

ggplot(ball_count, aes(x = Day, y = PercentPicked)) +geom_boxplot()+geom_point(data=latestweek, colour="red") + ggtitle("Daily Pick Rate", subtitle = "Last Week is shown in red") ## Box plot of the pick rate 

ggplot(ball_count, aes(x = Date, y = BallsDispensed)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Percentage of Balls Picked",
       x = "Date",
       y = "Percent Picked") 

ggplot(latestweek, aes(x = Date)) +
  geom_line(aes(y = cumsum(TotalBalls), colour = "Total Balls Picked")) +
  geom_line(aes(y = cumsum(BallsDispensed), colour = "Balls Dispensed")) +
  ylim(0, 50000) +
  labs(title = "Balls Dispensed per Week", x = "Date", y = "Cumulative Balls Dispensed") +
  scale_colour_manual(values = c("Total Balls Picked" = "red", "Balls Dispensed" = "blue"))




## Cumulative by day

sampledf <- read.csv("Downloads/February2023BallsDispensedbyDayofMonth.csv")
sampledata<- subset(sampledf, category %in% c(20,21,22))
sampleweek<- subset(ball_count, Week == "5")

Daydispensed <- as.Date(paste("2023-02-", sampledata$category, sep=""))
sampledata<-cbind(sampledata,Daydispensed)
sampledata <- subset(sampledata, select = -c(category))

benchmark<-cbind(sampleweek,sampledata)
benchmark


ggplot(benchmark, aes(x = Date))+geom_line(aes(y=cumsum(Balls),colour="red")) + geom_line(aes(y=cumsum(TotalBalls),colour="blue"))
