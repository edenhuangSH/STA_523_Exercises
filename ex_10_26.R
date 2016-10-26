## Exercise 1

library(rbenchmark)
library(microbenchmark)

good = function()
{
  res = rep(NA, 1e4)
  for(i in seq_along(res))
  {
    res[i] = sqrt(i)
  }
}

bad = function()
{
  res = numeric()
  for(i in 1:1e4)
  {
    res = c(res,sqrt(i))
  }
}

best = function()
{
  sqrt(1:1e4)
}

m = microbenchmark(
  bad(),
  good(),
  best(),
  times=100
)

b = benchmark(
  bad(),
  good(),
  best(),
  replications = 50
)


## Exercise 2

set.seed(523)
d = data.frame(matrix(rnorm(1e2 * 10),ncol=10))


func_apply = function()
{
  apply(d,1,max)
}
  
func_for = function()
{
  res = rep(NA, nrow(d))
  for(i in 1:nrow(d))
  {
    res[i] = max(d[i,])
  }
}
  
func_dplyr = function()
{
  d %>% 
    setNames(letters[1:10]) %>% 
    rowwise() %>%
    summarize(max = max(a,b,c,d,e,f,g,h,i,j)) %>%
    unlist()
}

benchmark(
  func_apply(),
  func_for(),
  func_dplyr(),
  replications = 5
)
