library(dplyr)
library(ggplot2)
library(doMC)
library(foreach)
library(parallel)

set.seed(3212016)
d = data.frame(x = 1:120) %>%
  mutate(y = sin(2*pi*x/120) + runif(length(x),-1,1))

l = loess(y ~ x, data=d)
d$pred_y = predict(l)
d$pred_y_se = predict(l,se=TRUE)$se.fit

n_rep = 10000

system.time({
  res = matrix(NA, ncol=n_rep, nrow=nrow(d))
  for(i in 1:ncol(res))
  { 
    bootstrap_samp = d %>% select(x,y) %>% sample_n(nrow(d), replace=TRUE)
    res[,i] = predict(loess(y ~ x, data=bootstrap_samp), newdata=d)
  }
})

system.time({
  registerDoMC(cores=4)
  res = foreach(i = 1:ncol(res), .combine = "cbind") %dopar% 
  {
    bootstrap_samp = d %>% select(x,y) %>% sample_n(nrow(d), replace=TRUE)
    predict(loess(y ~ x, data=bootstrap_samp), newdata=d)
  }
})

system.time({
  res = mclapply(
    mc.cores = 4,
    1:ncol(res),
    function(i)
    {
      bootstrap_samp = d %>% select(x,y) %>% sample_n(nrow(d), replace=TRUE)
      predict(loess(y ~ x, data=bootstrap_samp), newdata=d)
    }
  ) %>% do.call(cbind, .)
})

# Calculate the 95% bootstrap prediction interval
d$bs_low = apply(res,1,quantile,probs=c(0.025), na.rm=TRUE)
d$bs_up  = apply(res,1,quantile,probs=c(0.975), na.rm=TRUE)

ggplot(d, aes(x,y)) +
  geom_point() +
  geom_line(aes(y=pred_y)) +
  geom_line(aes(y=pred_y + 1.96 * pred_y_se), color="red") +
  geom_line(aes(y=pred_y - 1.96 * pred_y_se), color="red") +
  geom_line(aes(y=bs_low), color="blue") +
  geom_line(aes(y=bs_up), color="blue")