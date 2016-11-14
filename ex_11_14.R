library(purrr)
library(listviewer)
library(dplyr)
library(tibble)
library(tidyr)

load("f1.Rdata")

races = f1$MRData$RaceTable$Races

race_name = map_chr(races, "raceName")
race_round = map_chr(races, "round") %>% paste("Race",.)
n_finished = map_int(races, ~ length(.$Results))

results = map(races, c("Results")) %>% flatten()

df = tibble(
  driver = paste(map_chr(results, c("Driver","givenName")),
                 map_chr(results, c("Driver","familyName"))),
  points = map_chr(results, "points") %>% as.integer(),
  position = suppressWarnings(map_chr(results, "positionText") %>% as.integer()),
  race = rep(race_name, n_finished),
  round = rep(race_round, n_finished)
)

driver_points = df %>% group_by(driver) %>% summarise(points = sum(points))

res = df %>% 
  select(driver, position, race) %>%
  mutate(race=factor(race,labels = unique(race))) %>%
  spread(race, position) %>% 
  left_join(driver_points) %>%
  arrange(desc(points))

