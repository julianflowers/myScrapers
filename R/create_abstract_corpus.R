## create corpus from abstracts

create_abstract_corpus <- function(df = search){
  
  if(!require(tidytext))install.packages("tidytext")
  require(tidytext)
  require(dplyr)
  
  abs_stopwords <- c("background:", "objective:", "purpose:", "results:", "methods:")
  
  tidy_corp <- df %>%
    mutate(text = paste(title, absText)) %>% 
    unnest_tokens(word, text, "words") %>%
    anti_join(stop_words) %>%
    filter(!word %in% abs_stopwords) %>%
    mutate(word = SnowballC::wordStem(word)) %>%
    filter(!str_detect(word, "``d.*")) %>%
    count(pmid, word) %>%
    bind_tf_idf(word, pmid, n)
  
  included <- pull(tidy_corp, pmid) %>%
    unique()
  
  out1 <- df %>%
    filter(pmid %in% included) %>%
    group_by(pmid) %>%
    mutate(row_id = row_number()) %>%
    filter(row_id == 1) %>%
    ungroup()
  
  out <- list(search = out1, corpus = tidy_corp)
  
}



