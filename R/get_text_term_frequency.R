## gets term frequency in pdfs for a dictionary of terms

get_text_term_frequency <- function(l, d, n = 1){
  
  require(tidyverse)
  require(quanteda)
  require(readtext)
  require(myScrapers)
  
  safe_readtext <- safely(readtext)
  
  links_df <- l %>%
    .[grepl("pdf", .)] %>%
    map(., ~(safe_readtext(.x))) %>%
    map(., "result") %>%
    map_df(., data.frame)

  corpus <- corpus(links_df$text)

  dfm <- dfm(corpus, remove = stopwords("en"), ngrams = 1:n) 
  lookup <- dfm_lookup(dfm, dictionary = d)
  lookup
  
}


