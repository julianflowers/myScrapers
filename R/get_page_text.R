# get page text


get_page_text <- function(url){
  
  require(httr)
  require(dplyr)
  require(rvest)
  
  text <- GET(url) %>%
    read_html() %>%
    html_nodes("p") %>%
    html_text()
  
  return(text)

}

