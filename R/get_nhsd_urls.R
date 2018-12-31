get_nhsd_urls <- function(url){
  
  require(rvest)
  require(tidyverse)
  
  
  read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href") %>% 
    .[grepl("statistical", .)]
}  



