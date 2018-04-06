## Downloads a table of NICE PH guidance




######################################

## pseudo code for nice_scraper


## extract/ create url list

## ph guidance contains ph or ng

get_nice_ph_guidance <- function(url){

require(rvest)
require(Rcrawler)  
require(tidyverse, quietly = TRUE)  



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
  
  
##  ref no

ref <- read_html(url) %>%
  html_nodes(".prod-title") %>%
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
  
results <- as.tibble(cbind(ref, title, date, rec))


  
results  
  
}



url_list <- paste0("https://www.nice.org.uk/guidance/ph", c(1,3, 5:32, 35:36, 38:56))

nice_guidance <- map_df(url_list, function(x) get_nice_ph_guidance(x))







nice_guidance %>%
  mutate(published = lead(date)) %>%
  filter(date!=published, !str_detect(date, "Last")) %>%
  mutate(updated = ifelse(str_detect(published, "Last"), published, NA)) %>%
  select(ref, title, date, updated, rec) %>%
  DT::datatable()
