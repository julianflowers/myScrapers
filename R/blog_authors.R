#e# get blog authors

get_blog_authors <- function(url = "https://publichealthmatters.blog.gov.uk"){
  
  
  library(Rcrawler)
  library(stringr)
  library(tidyverse)
  
  getLinks <- LinkExtractor(url)[[2]]
  
  authors <- unique(getLinks[grepl("author",getLinks)])
  
  authors <- str_split(authors, "/", n  = 5)
  
  auths <- map_chr(authors, c(5,1))
  auths <- map_chr(auths, function(x) gsub("/", "", x))
  
  
  return(auths)
  
}



