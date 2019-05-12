
## bigram maker


create_bigrams <- function(df, text){
  require(tidytext)
  require(dplyr)
  require(Matrix)
 text <- enquo(text)
  df %>%
    unnest_tokens(bigram, !!text, token = "ngrams", n = 2) %>%
    separate(bigram, c("w1", "w2"), sep = " ") %>%
    dplyr::filter(!w1 %in% stop_words$word) %>%
    dplyr::filter(!w2 %in% stop_words$word) %>%
    unite(bigram, c("w1", "w2"), sep = " ")
}




