# get page csv/xls


get_page_csvs <- function(url){
  
  require(httr)
  require(tidyverse)
  require(rvest)
  
  csv <- GET(url) %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[grepl("csv$|xls.$", .)]
    
  
  return(csv)
  
}
