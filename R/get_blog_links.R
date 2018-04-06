get_blog_links <- function(url) {
  
  require(Rcrawler)
  
  links <- map(url, function(x) Rcrawler::LinkExtractor(x)[2])
  links_flat <- flatten(links)
  cat_links <- map(links_flat, function(x) x[!grepl("author", x)])
  cat_links <- map(cat_links, function(x) x[!grepl("category", x)])
  cat_links <- map(cat_links, function(x) x[!grepl("page|feed", x)])
  cat_links <- map(cat_links, function(x) x[!grepl("public-health-matters|subscribe", x)])
  cat_links <- flatten(cat_links)
  cat_links <- unique(cat_links)
  cat_links <- map_chr(cat_links, 1)
}
