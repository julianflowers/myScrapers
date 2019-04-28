## gets term frequency in web texts for a dictionary of terms

get_blog_term_frequency <- function(links, dictionary, n = 1){
  
  require(tidyverse)
  require(quanteda)
  require(readtext)
  require(myScrapers)
  
  safe_readtext <- safely(get_page_text)
  
  links_df <- links %>%
    #.[grepl("pdf", .)] %>%
    purrr::map(., ~(safe_readtext(.x))) %>%
    purrr::map(., ~(paste(.x, collapse = ","))) %>%
    purrr::map(., data.frame) %>%
    bind_rows(., .id = "date") 
  
  corpus <- corpus(links_df$.x..i..)
  docvars(corpus, "group") <- links_df$date
  
<<<<<<< HEAD
  dfm <- dfm(corpus, remove = stopwords("en"), ngrams = 1:n ) 
=======
  dfm <- dfm(corpus, remove = stopwords("en"), ngrams = 1:n) 
>>>>>>> 042b6954f8f9a71bdaecf06dc0fa6efd96392d71
  lookup <- dfm_lookup(dfm, dictionary = dictionary)
  lookup
  
}


