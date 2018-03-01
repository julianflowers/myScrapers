
## bigram maker

create_bigrams <- function(ds, text){
  require(tidytext)
  require(tidyverse)
 text <- enquo(text)
  ds %>%
    unnest_tokens(bigram, !!text, token = "ngrams", n = 2) %>%
    separate(bigram, c("w1", "w2"), sep = " ") %>%
    filter(!w1 %in% stop_words$word) %>%
    filter(!w2 %in% stop_words$word) %>%
    unite(bigram, c("w1", "w2"), sep = " ")
  
  
}



