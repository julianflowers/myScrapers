
## bigram maker

create_bigrams <- function(ds, group){
  require(tidytext)
  group <- enquo(group)
  ds %>%
    group_by(!!group) %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    separate(bigram, c("w1", "w2"), sep = " ") %>%
    filter(!w1 %in% stop_words$word) %>%
    filter(!w2 %in% stop_words$word) %>%
    unite(bigram, c("w1", "w2"), sep = " ")
  
  
}



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
    
