# get page csv/xls


get_page_links <- function(url){
  
  require(httr)
  require(tidyverse)
  require(rvest)
  
  csv <- GET(url) %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[grepl("csv$|xls.$")]
    
  
  return(csv)
  
}