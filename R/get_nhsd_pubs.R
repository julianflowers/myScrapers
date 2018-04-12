get_nhsd_pubs <- function(url){
  
  require(rvest)
  require(tidyverse)
  
  pubs <- read_html(url) %>%
    html_nodes(".title") %>%
    html_attr("href")
  
  pubs
  
  
}
