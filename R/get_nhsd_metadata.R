## Function to get descriptions of NHSD datasets



get_nhsd_metadata <- function(url){
  
  require(tidyverse)
  require(rvest)
  
  meta <- read_html(url) %>%
    html_nodes(".textblock-default") %>%
    html_text() %>%
    str_replace_all(., "\\r", "") %>%
    str_replace_all(., "\\t", "") %>%
    str_replace_all(., "\\n", "") %>%
    tm::stripWhitespace() %>%
    paste(.,  collapse = ";") %>%
    cbind(url)
}