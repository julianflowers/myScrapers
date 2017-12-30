#e# get blog categories

get_blog_categories <- function(url = "https://publichealthmatters.blog.gov.uk"){
  
  
  library(Rcrawler)
  library(stringr)
  library(tidyverse)
  
  getLinks <- LinkExtractor(url)[[2]]
  
  categories <- unique(getLinks[grepl("category",getLinks)])
  
  categories <- str_split(categories, "/", n  = 5)
  
  cats <- map_chr(categories, c(5,1))
  
  cats <- map_chr(cats, function(x) gsub("/", "", x))
  
  return(cats)
  
}


