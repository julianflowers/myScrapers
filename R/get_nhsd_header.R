## Function to get titles of publications from NHSD website


get_nhsd_header <- function(url){
  
  require(tidyverse)
  require(rvest)
  
  head <- read_html(url) %>%
    html_nodes("h1") %>%
    html_text() %>%
    str_replace_all(., "\\r", "") %>%
    str_replace_all(., "\\t", "") %>%
    str_replace_all(., "\\n", "") %>%
    tm::stripWhitespace() %>%
    #paste(.,  collapse = ";") %>%
    cbind(url)
}  