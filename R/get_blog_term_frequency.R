## gets term frequncy in web texts for a dictionary of terms

get_term_frequency <- function(links, dictionary, id = date, n = 1){
  
  require(tidyverse)
  require(quanteda)
  require(readtext)
  require(myScrapers)
  
  safe_readtext <- safely(get_page_text)
  
  links_df <- links %>%
    #.[grepl("pdf", .)] %>%
    map(., ~(get_page_text(.x))) %>%
    map(., ~(paste(.x, collapse = ","))) %>%
    map(., data.frame) %>%
    bind_rows(., .id = "id") 
  
  corpus <- corpus(links_df$.x..i..)
  docvars(corpus, "group") <- links_df$id
  
  dfm <- dfm(corpus, remove = stopwords("en")) 
  lookup <- dfm_lookup(dfm, dictionary = dictionary, ngram = 1:n)
  lookup
  
}
