#' ---
#' title: "Term frequency in titles of journals relevant to wildlife conservation"
#' subtitle: "Pubmed searches"
#' author: "Julian Flowers"
#' date: "`r Sys.Date()`"
#' parameters:
#'     search: "Animal Conservation"

#' ---

#+ knitr::opts_chunk$set(echo = FALSE, cache = TRUE, message = FALSE, warning = FALSE)

devtools::install_github("julianflowers/myScrapers")
library(myScrapers)
library(tidyverse)

search <- paste0(parameters$search, "[ta]")

ncbi_key <- Sys.getenv("ncbi_key")

n <- 10000

start <- 2000
end <- 2021

test <- pubmedAbstractR(search = search, n = n, ncbi_key = ncbi_key, start = start, end = end)

#' ## annual counts

test$abstracts %>%
  count(journal, year) %>%
  ggplot(aes(year, n, colour = journal, group = journal)) +
  geom_line() +
  viridis::scale_color_viridis(discrete = TRUE)

#' ## keyword parse

#' ### simple title analysis

library(tidytext); library(quanteda)

word_freq <- test$abstracts %>%
  unnest_tokens(word, title, "words") %>%
  anti_join(stop_words) %>%
  filter(!str_detect(word, "\\d")) %>%
  count(journal, year, word, sort = T) 

word_freq %>%
  filter(n > 10) %>%
  ggplot(aes(year, fct_rev(word), fill = n)) +
  geom_tile() +
  #facet_wrap(~journal) +
  viridis::scale_fill_viridis(direction = -1) +
  theme_minimal()

### bigrams
  
big <- create_bigrams(test$abstracts, title)

big <- big %>%
  count(year, bigram, sort = TRUE) %>%
  filter(n > 3) 

big %>%
  ggplot(aes(year, fct_rev(bigram), fill = n)) +
  geom_tile() +
  viridis::scale_fill_viridis(direction = -1) +
  theme_minimal()


test1 <- get_ss_data(search = "Birding World", n = 100)


