## gets term frequency in web texts for a dictionary of terms

get_blog_term_frequency <- function(links, dictionary, n = 1){
  
  require(dplyr)
  require(purrr)
  require(quanteda)
  require(readtext)

  safe_readtext <- safely(get_page_text)
  
  links_df <- links %>%
    #.[grepl("pdf", .)] %>%
    purrr::map(., ~(safe_readtext(.x))) %>%
    purrr::map(., ~(paste(.x, collapse = ","))) %>%
    purrr::map(., data.frame) %>%
    bind_rows(., .id = "date") 
  
corpus <- corpus(links_df$.x..i..)
docvars(corpus, "group") <- links_df$date
  
dfm <- dfm(corpus, remove = stopwords("en"), ngrams = 1:n) 
lookup <- dfm_lookup(dfm, dictionary = dictionary)
lookup
  
}


