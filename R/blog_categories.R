#e# get blog categories

# categories - get a list of ph matters categories
get_blog_categories <- function(url) {
  
  require(Rcrawler)
  require(tidyverse)
  
  links <- map(url, function(x) Rcrawler::LinkExtractor(x)[2])
  links_flat <- flatten(links)
  cat_links <- map(links_flat, function(x) x[grepl("category", x)])
  
  cat <- map(cat_links, function(x) str_split(x, "/"))
  
  cat_list <- map_chr(flatten(cat), 5) %>% unique()
  
}
