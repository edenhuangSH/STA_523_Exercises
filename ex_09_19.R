library(dplyr)
library(nycflights13)
library(ggplot2)
library(lubridate)

## Demo 1

# How many *flights to Los Angeles (LAX)* did each of the 
# *legacy carriers (AA, UA, DL or US)* have *in May* *from JFK*, 
# and what was their average duration?

flights %>% 
  select(dest, origin, carrier, month, air_time) %>%
  filter(dest == "LAX", month == 5, origin == "JFK") %>%
  filter(carrier %in% c("AA", "UA", "DL", "US")) %>%
  group_by(carrier) %>%
  summarize(n = n(), avg_dur = mean(air_time, na.rm=TRUE))



## Demo 2

# Create a time series plot of each of the legacy carriers' 
# average departure delay by day of the week and origin airport.

## grouping by day of the week

delay = flights %>% 
          select(origin, carrier, dep_delay, month, day, year) %>%
          filter(carrier %in% c("AA", "UA", "DL", "US")) %>%
          mutate(date = paste(month,day,year,sep="/") %>% mdy()) %>%
          mutate(wday = wday(date,label = TRUE)) %>%
          group_by(origin, wday) %>% 
          summarize(avg_dep_delay = mean(dep_delay, na.rm=TRUE))
  
ggplot(delay, aes(x=wday,y=avg_dep_delay,col=origin)) + geom_point()
  

## grouping by day of the month

delay = flights %>% 
  select(origin, carrier, dep_delay, day) %>%
  filter(carrier %in% c("AA", "UA", "DL", "US")) %>%
  group_by(origin, day) %>% 
  summarize(avg_dep_delay = mean(dep_delay, na.rm=TRUE))

ggplot(delay, aes(x=day,y=avg_dep_delay,col=origin)) + geom_line()



