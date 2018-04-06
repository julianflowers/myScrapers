## Function to identify spreadsheets on NHSD website


get_nhsd_sheets <- function(url){
  
  require(rvest)
  require(tidyverse)
  
  
  sheets <- read_html(url) %>%
    html_nodes(".extension\\.xlsx") %>%
    html_attr("href") %>%
    cbind(url)
}