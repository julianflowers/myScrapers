get_nhsd_urls <- function(url){
  
  require(rvest)
  require(tidyverse)
  
  
  read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href") %>% 
    .[grepl("statistical", .)]
}  


url <- "https://digital.nhs.uk/search/document-type/publication/publicationStatus/true?page="

urls <- paste0(url, 1:200)


map(urls,  function(x) get_nhsd_urls(x))


