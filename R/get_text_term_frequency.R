## gets term frequency in pdfs for a dictionary of terms

get_text_term_frequency <- function(l, d, n = 1){
  
  require(tidyverse)
  require(quanteda)
  require(readtext)

  safe_readtext <- safely(readtext)
  
  links_df <- l %>%
    .[grepl("pdf", .)] %>%
    purrr::map(., ~(safe_readtext(.x))) %>%
    purrr::map(., "result") %>%
    purrr::map_df(., data.frame)

  corpus <- corpus(links_df, text_field = "text")

  dfm <- dfm(corpus, remove = stopwords("en"), ngrams = 1:n) 
  lookup <- dfm_lookup(dfm, dictionary = d)
  lookup
  
}

links_df <- files %>%
  .[grepl("pdf", .)] %>%
  purrr::map(., ~(safe_readtext(.x))) %>%
  purrr::map(., "result") %>%
  purrr::map_df(., data.frame)

str(links_df)
corpus(links_df, text_field = "text")

str(links_df)
