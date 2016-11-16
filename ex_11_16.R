library(purrr)
library(magrittr)
library(stringr)
library(dplyr)
library(tm)
library(parallel)

data = list(
  "1" = "the quick brown",
  "2" = "fox jumped over",
  "3" = "the lazy dog the"
)

data = readLines("/data/Shakespeare/hamlet.txt") %>% as.list()

# Map step

map_count_words = function(val)
{
  stopifnot(length(val) == 1)
  
  val %>%
    tolower() %>%
    str_split(" ") %>%
    {.[[1]]} %>%
    str_trim() %>%
    .[. != ""] %>%
    .[! . %in% stopwords("en")] %>%
    table() %>% 
    as.list()
}

res_map = lapply(data, map_count_words) %>% flatten()

# Shuffle step

keys = names(res_map) %>% unique()
res_shuf = lapply(keys, function(key) unlist(res_map[names(res_map) == key]) %>% setNames(NULL)) %>% setNames(keys)

# Reduce step

reduce_func = sum
res_red = lapply(res_shuf, reduce_func)

(tbl = data_frame(keys = names(res_red), 
           values = unlist(res_red)) %>%
  arrange(desc(values)))



### Generic MapReducer

mapreduce = function(map_func, reduce_func, return_table=TRUE, mc.cores=4)
{
  function(data)
  {
    res_map = mclapply(data, map_func, mc.cores=mc.cores) %>% flatten()
    
    keys = names(res_map) %>% unique()
    res_shuf = mclapply(keys, 
                        function(key) unlist(res_map[names(res_map) == key]) %>% setNames(NULL),
                        mc.cores = mc.cores
               ) %>% setNames(keys)
    
    res_red = mclapply(res_shuf, reduce_func, mc.cores = mc.cores)
    
    if (return_table)
      data_frame(keys = names(res_red), 
                 values = unlist(res_red)) %>%
        arrange(desc(values))
    else
      res_red
  }
}

word_count = mapreduce(map_count_words, sum, mc.cores=8)
word_count(data)



