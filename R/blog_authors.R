#e# get blog authors

get_blog_authors <- function(url) {
  
  require(Rcrawler)
  
  links <- map(urls, function(x) Rcrawler::LinkExtractor(x)[2])
  links_flat <- flatten(links)
  cat_links <- map(links_flat, function(x) x[grepl("author", x)])
  
  cat <- map(cat_links, function(x) str_split(x, "/"))
  
  cat_list <- map_chr(flatten(cat), 5) %>% unique()
  
}