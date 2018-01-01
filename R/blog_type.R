#e# get blog authors or categories for a given url

get_blog_type <- function(url = "https://publichealthmatters.blog.gov.uk", type = "author" ){
  
  if(!type %in% c("category", "author"))
     
    stop ("type must be 'author' or 'category'")
  
  library(Rcrawler)
  library(stringr)
  library(tidyverse)
  
  ## extracts urls from page
  getLinks <- LinkExtractor(url)[[2]]
  
  ## remove duplicates
  links <- unique(getLinks[grepl(type ,getLinks)])
  
  # split url
  links <- str_split(links, "/", n  = 5)
  
  # extract 5th element (author)
  links1 <- map_chr(links, c(5,1))
  
  # remove forward slashes
  links1 <- map_chr(links1, function(x) gsub("/", "", x))
  
  
  return(links1)
  
}


