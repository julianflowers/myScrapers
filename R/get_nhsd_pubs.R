get_nhsd_pubs <- function(url){
  
  pubs <- read_html(url) %>%
    html_nodes(".title") %>%
    html_attr("href")
  
  pubs
  
  
}