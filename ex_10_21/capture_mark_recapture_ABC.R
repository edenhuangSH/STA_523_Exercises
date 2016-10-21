n_sim = 1e5

# Data
n_marked = 5 # n
n_recaptured = 10 # K
n_recap_marked = 3 # k

# Prior
unif_min = 10
unif_max = 100
unif_prior = sample(unif_min:unif_max, n_sim, replace = TRUE)

pois_lambda = 50
pois_prior = rpois(n_sim, pois_lambda)

# Generative model
gen_model = function(n_total)
{
  marked = rep(1, n_marked)
  unmarked = rep(0, n_total-n_marked)
  
  pop = c(marked, unmarked)
 
  sum(sample(pop, n_recaptured, replace=FALSE))
}

# Simuate data
sim_unif = sapply(unif_prior, gen_model)
sim_pois = sapply(pois_prior, gen_model)


# Posterior draws
unif_post = unif_prior[sim_unif == n_recap_marked]
pois_post = pois_prior[sim_pois == n_recap_marked]


par(mfrow=c(1,2))
n = 10:100

plot(density(unif_post))
lines(n, rep(1/length(n),length(n)), col='red')

plot(density(pois_post))
lines(n, dpois(n,lambda = pois_lambda),col='red')
