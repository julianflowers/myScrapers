ibrary(rvest)
library(Rcrawler)

nice <- "https://www.nice.org.uk/guidance/ph"

niceurls <-paste0(nice, 1:70)

t <- map(niceurls[11], function(x) LinkExtractor(x))
t[2]

LinkExtractor(niceurls[65])[2]

t2 <- t[2]

t3 <- t2[[1]][grepl("ph1", t2[[1]])]


test <- read_html(t3[6]) %>%
  html_nodes(".span9") %>%
  html_text()

head <- read_html(t3[6]) %>%
  html_nodes("h1") %>%
  html_text()

date <- read_html(t3[6]) %>%
  html_nodes(".published-date") %>%
  html_text() %>%
  str_replace_all("\\n", "") %>%
  tm::stripWhitespace()



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



url_list <- paste0("https://www.nice.org.uk/guidance/ph", c(1,3, 5:32, 35:36, 38:56))

url_ng <- paste0("https://www.nice.org.uk/guidance/ng", c(6:7, 13, 16, 30, 32, 34, 44, 48, 55, 58, 60, 63:64, 68, 70))
urls <- c(url_list, url_ng)
guidance = str_extract(urls, "ph[0-9].*$|ng[0-9].*$")
nice_guidance <- purrr::map_df(urls, function(x) get_nice_ph_guidance(x)) 


 nice_guidance %>%
  mutate(published = ifelse(str_detect(date, "Last"), date, NA )) %>%
  mutate(date = lag(date)) %>%
  filter(stringr::str_detect(rec, "^ Next")) %>%
  View()
         