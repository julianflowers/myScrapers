

## function for text summarisation based on `textrank`
text_summariser <- function(text, n = 6){
  
#cat("Given a text returns a summary (most important sentences) based on Google's pagerank algorithm. Set n to change no of sentences in summary.\n NB may take some time to run")  

require(pacman)
p_load(tidyverse, quanteda, textrank, tidytext, lettercase)

## tokenise into sentences
sentences <- tibble(text = text) %>%
  unnest_tokens(sentence, text, token = "sentences") %>%
  mutate(sentence_id = row_number()) %>%
  select(sentence_id, sentence)

## tokenise sentences into workds
article_words <- sentences %>%
  unnest_tokens(word, sentence)

## remove stopwords
article_words <- article_words %>%
  anti_join(stop_words, by = "word")

## textrank trial

article_summary <- textrank_sentences(data = sentences, terminology = article_words)

result <- data.frame(sentence = article_summary$sentences$sentence, textrank = article_summary$sentences$textrank)


result <- result %>%
  arrange(-textrank) %>%
  head(n) %>%
  mutate(sentence = paste0(toupper(str_sub(sentence, 1, 1)), str_sub(sentence, 2, str_length(sentence)))) %>%
  mutate(summary = paste(sentence, collapse = " ")) %>%
  pull(summary) %>%
  unique()

#cat(result)

}




