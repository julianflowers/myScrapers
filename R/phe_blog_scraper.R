## identify and download phe blogs


get_blog_text <- function(category = "duncan-selbie-friday-message"){

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


