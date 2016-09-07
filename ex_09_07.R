## Exercise 1

primes = c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 
           47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)
values = c(3, 4, 12, 19, 23, 48, 50, 61, 63, 78)

### Wrong problem - find the primes

for(x in values)
{
  for(p in primes)
  {
    if (x==p)
    {
      cat(x,"")
      break
    }
  }
}

### Correct problem - find the non-primes

for(x in values)
{
  found = FALSE
  for(p in primes)
  {
    if (x==p)
    {
      found = TRUE
      break
    }
  }
  
  if (found == FALSE)
  {
    cat(x, "")
  }
}

### Better solution

values[!values %in% primes]

