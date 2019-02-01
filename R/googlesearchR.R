# A script to search google

googlesearchR <- function(search, n = 100 ){

  require(stringr)
  require(rvest)
  require(httr)
  require(purrr)
  
  search <- str_replace_all(search, " ", "+")
  
  u <- paste0("https://www.google.co.uk/search?q=", search, "&num=", n )
  
  html <- GET(u)
  
  doc <- read_html(html)
  
  attrs <- html_nodes(doc, "a") %>% html_attr("href")
  
  #links <- grep("http://", attrs, fixed = TRUE, value=TRUE)
  links <- str_replace_all(attrs, "&sa=.+|%3.+", "")
  links <- str_replace_all(links, "\\/url\\?q=", "")
  links <- str_extract_all(links, "^http.+")
  links <- str_replace_all(links, "http://webcache.googleusercontent.com/search", "") 
  links <- str_extract_all(links, "^http.+")
  links <- purrr::flatten(links)
  links <- links[12:length(links)]
  
  print(links)
  
}


