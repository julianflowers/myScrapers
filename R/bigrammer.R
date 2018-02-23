
## bigram maker

create_bigrams <- function(ds, group){
  require(tidytext)
  require(tidyverse)
  group <- enquo(group)
  ds %>%
    group_by(!!group) %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    separate(bigram, c("w1", "w2"), sep = " ") %>%
    filter(!w1 %in% stop_words$word) %>%
    filter(!w2 %in% stop_words$word) %>%
    unite(bigram, c("w1", "w2"), sep = " ")
  
  
}



