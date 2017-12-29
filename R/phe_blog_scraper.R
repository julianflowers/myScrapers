## identify and download phe blogs


phe_blog_scraper <- function(category = "duncan-selbie-friday-message"){

    require(Rcrawler)
    require(rvest)
    require(tidyverse)
    require(stringr)
    require(readtext)
    require(tm)
    require(tidytext)
    require(quanteda)

  url1 <- "https://publichealthmatters.blog.gov.uk/category/"
  
  urls <- paste0(url1, category)
  

pages <- LinkExtractor(urls)[[2]]

urls1 <- pages[grepl(category,pages)]

}        

urls2 <- phe_blog_scraper()
