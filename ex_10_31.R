library(magrittr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(readr)

nyc = read_csv("/data/nyc_parking/NYParkingViolations.csv") %>% 
  setNames(make.names(names(.))) %>%
  select(Registration.State:Issuing.Agency, 
         Violation.Location, Violation.Precinct, Violation.Time,
         House.Number:Intersecting.Street, Vehicle.Color) %>%
  mutate(Issue.Date = mdy(Issue.Date)) %>% 
  mutate(Issue.Day = day(Issue.Date),
         Issue.Month = month(Issue.Date),
         Issue.Year = year(Issue.Date),
         Issue.WDay = wday(Issue.Date, label=TRUE)) %>%
  filter(Issue.Year %in% 2013:2014)



# 1. Which day had the most tickets issued? 
#    Which day the least? Be careful about your date range.

nyc %>% 
  select(Issue.Date) %>%
  filter(Issue.Date >= mdy("7/15/2013"), Issue.Date <= mdy("6/15/2014")) %>%
  group_by(Issue.Date) %>%
  summarize(n=n()) %>%
  ungroup() %>%
  filter(n %in% range(n))
  

# 2a. Create a plot of the weekly pattern (tickets issued per day of the week) 

nyc %>% 
  group_by(Issue.WDay) %>%
  summarize(n=n()) %>%
  ggplot(aes(x=Issue.WDay,y=n)) + geom_point()

# 2b. When are you most likely to get a ticket and
#     when are you least likely to get a ticket?

nyc %>% 
  group_by(Issue.WDay) %>%
  summarize(n=n()) %>%
  ungroup() %>%
  filter(n %in% range(n))


# 3. Which precinct issued the most tickets to Toyotas?


# 4. How many different colors of cars were ticketed?

nyc$Vehicle.Color %>% table() %>% .[.>2000]


