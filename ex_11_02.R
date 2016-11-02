library(dplyr)
library(readr)
library(magrittr)
library(lubridate)

nyc = read_csv("/data/nyc_parking/NYParkingViolations.csv")
fines = read_csv("/data/nyc_parking/fine_definition.csv")

nyc %<>% 
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

fines_revised = rbind(
  fines %>% select(code, fine = fine_manhattan) %>% mutate(manhattan=1),
  fines %>% select(code, fine = fine_other) %>% mutate(manhattan=0)
)

nyc_fines = nyc %>% 
  mutate(manhattan = as.integer(Violation.Precinct >= 1 & Violation.Precinct <= 34)) %>%
  select(code = Violation.Code, manhattan)
  
res = left_join(nyc_fines, fines_revised)
total_revenue = sum(res$fine, na.rm=TRUE)
