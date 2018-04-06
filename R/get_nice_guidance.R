

## pseudo code for nice_scraper


## extract/ create url list

## ph guidance contains ph or ng

get_nice_ph_guidance <- function(url){
  
  require(rvest)
  require(Rcrawler)  
  require(tidyverse, quietly = TRUE)  
  
  ## Number
  
  guidance <- read_html(url) %>%
    html_nodes(".prod_title") %>%
    html_text()
  
  ## title
  
  title <- read_html(url) %>%
    html_nodes("h1") %>%
    html_text()
  
  ## date
  
  date <- read_html(url) %>%
    html_nodes(".published-date") %>%
    html_text() %>%
    str_replace_all("\\n", "") %>%
    tm::stripWhitespace()
  
  ## recommendations
  
  url1 <- paste0(url, "/chapter/1-Recommendations")
  
  rec <- read_html(url1) %>%
    html_nodes(".span9") %>%
    html_text() %>%
    str_replace_all("\\n", "") %>%
    str_replace_all("\\r","") %>%
    tm::stripWhitespace()
  
  
  ## output
  
  results <- as.tibble(cbind(guidance, title, date, rec))
  
  results  
  
}




