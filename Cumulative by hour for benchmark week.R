library(googlesheets4)
benchmark<- read_sheet("https://docs.google.com/spreadsheets/d/1Q9JTlz606MctMuJGlP94hCtT0VkdubDn1hw7BM5VpX4/edit?usp=sharing")
library(ggplot2)
attach(benchmark)

benchmark$time1 <- format(as.POSIXct(benchmark$time, format='%I %p', tz='UTC'), format='%H:%M', tz='UTC')
benchmark <- benchmark[order(benchmark$time1),]
benchmark <- benchmark[order(benchmark$Date),]
datetime <- paste(benchmark$Date, benchmark$time1)
datetime <- as.POSIXct(datetime, format='%Y-%m-%d %H:%M', tz='UTC')
ggplot(benchmark, aes(x=datetime)) + 
  geom_line(aes(y=cumsum(BallsSold), color="Balls Dispensed")) +
  geom_line(aes(y=cumsum(BallCollected), color="Balls Picked")) +
  labs(title="Total Ball Picking and Dispensing by hour for 06/13-14",
       x="Date/Time", y="Total Balls",
       color="Legend:") +
  scale_color_manual(values=c("Balls Picked"="lightblue", "Balls Dispensed"="plum3"))
benchmark