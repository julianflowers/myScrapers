library(myScrapers)
library(tidytext)
library(wordcloud)

mlph <- pubmedAbstractR("social media population health")

str(mlph)

## text cleaner

clean_abstracts <- function(ds){
  
  ds$abstract <- tm::removeNumbers(ds$abstract)
  ds$abstract <- tm::stripWhitespace(ds$abstract)
  ds$abstract <- tm::removePunctuation(ds$abstract)
  ds$abstract <- tm::stemDocument(ds$abstract)
  
}

clean_abstracts(mlph)

## bigram maker

create_bigrams <- function(ds){
  require(tidytext)
  
  ds %>%
    group_by(DOI) %>%
    unnest_tokens(bigram, abstract, token = "ngrams", n = 2) %>%
    separate(bigram, c("w1", "w2"), sep = " ") %>%
    filter(!w1 %in% stop_words$word) %>%
    filter(!w2 %in% stop_words$word) %>%
    unite(bigram, c("w1", "w2"), sep = " ")
  
  
}

mlph_bigram <- create_bigrams(mlph)

mlph_bigram %>%
  group_by(year, bigram) %>%
  count(sort = TRUE) %>%
  filter(n > 100) %>%
  ggplot(aes(year, n)) +
  geom_col() +
  facet_wrap(~bigram, scales = "free") +
  govstyle::theme_gov() +
  theme(strip.text.x = element_text(size = rel(.5)), 
        axis.text.x = element_text(size = rel(.5)))
    
