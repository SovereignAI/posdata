library(googlesheets4)
ball_count<- read_sheet("https://docs.google.com/spreadsheets/d/17XOdG71OU7sDT1PvT2_Ny_saipLvbh2u6w0mLhyXr5I/edit#gid=228679708")
ls(ball_count)

library(ggplot2)
attach(ball_count)

latestmonth <- subset(ball_count, Week %in% c("11", "12", "13", "14"))

ggplot(latestmonth) +
  geom_line(aes(x = Date, y = TotalBalls, colour="Balls Picked")) +
  geom_line(aes(x = Date, y = BallsDispensed, colour="Balls Dispensed")) +
  ggtitle("Daily Ball Picked vs Balls Dispensed") +
  scale_color_manual(name = "Legend", values = c("red", "black")) +
  ylim(0, max(latestmonth$TotalBalls)) +
  guides(color = guide_legend(title = NULL, override.aes = list(linetype = "solid")))


###


slope <- lm(PercentPicked ~ Date, data = latestmonth)$coefficients[2]
intercept <- lm(PercentPicked ~ Date, data = latestmonth)$coefficients[1]

ggplot(latestmonth) +
  geom_line(aes(x = Date, y = PercentPicked)) +
  geom_abline(slope = slope, intercept = intercept, linetype = "dashed", color = "red") +
  ggtitle("Daily Ball count and Percent Picked") +
  labs(subtitle = "Trend line of Percent Picked based on Date") +
  ylim(0, 1.2)

##

library(dplyr)
library(lubridate)

weekly_data <- latestmonth %>%
  group_by(Year = year(Date), Week = week(Date)) %>%
  summarize(PercentPicked = mean(PercentPicked), Date = min(Date))

slope <- lm(PercentPicked ~ Date, data = weekly_data)$coefficients[2]
intercept <- lm(PercentPicked ~ Date, data = weekly_data)$coefficients[1]

ggplot(weekly_data) +
  geom_line(aes(x = Date, y = PercentPicked)) +
  geom_abline(slope = slope, intercept = intercept, linetype = "dashed", color = "red") +
  ggtitle("Weekly Ball count and Percent Picked") +
  labs(subtitle = "Trend line of Percent Picked based on Date") +
  ylim(0.25, 1) +
  xlab("Week of Year") +
  ylab("Percent Picked") +
  theme_bw()

##

library(dplyr)
library(ggplot2)

latestmonth <- ball_count %>%
  filter(Week %in% c("11", "12", "13", "14")) %>%
  group_by(Week) %>%
  summarize(Date = last(Date),
            TotalBalls = sum(TotalBalls),
            BallsDispensed = sum(BallsDispensed))
slope <- lm(PercentPicked ~ Date, data = weekly_data)$coefficients[2]
intercept <- lm(PercentPicked ~ Date, data = weekly_data)$coefficients[1]


ggplot(latestmonth) +
  geom_line(aes(x = Date, y = PercentPicked)) +
  geom_abline(slope = slope, intercept = intercept, linetype = "dashed", color = "red") +
  geom_line(aes(x = Date, y = TotalBalls, colour = "Balls Picked")) +
  geom_line(aes(x = Date, y = BallsDispensed, colour = "Balls Dispensed")) +
  ggtitle("Weekly Ball Picked vs Balls Dispensed") +
  scale_color_manual(name = "Legend", values = c("Balls Dispensed" = "black", "Balls Picked" = "red")) +
  ylim(0, max(latestmonth$BallsDispensed)) +
  guides(color = guide_legend(title = NULL, override.aes = list(linetype = "solid")))


