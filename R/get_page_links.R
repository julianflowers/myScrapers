# get page links


get_page_links <- function(url){
  
  require(httr)
  require(tidyverse)
  require(rvest)
  
  links <- GET(url) %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href")
  
  return(links)
  
}