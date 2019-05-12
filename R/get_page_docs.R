# get page docs


get_page_docs <- function(url){
  
  require(httr)
  require(dplyr)
  require(rvest)
  
  docs <- GET(url) %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[grepl("pdf$|doc.$", .)]
  
  return(docs)
  
}
