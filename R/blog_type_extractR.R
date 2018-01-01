# Extracts a dataframe of blog categories or authors depending on input



blog_type_extractor <- function(type = type){
  
  require(tidyverse)
  source("blog_type.R")
  
  if(!type %in% c("category", "author"))
    
  stop ("type input must be 'author' or 'category'")
  
  urls_all <- as.vector(paste0("https://publichealthmatters.blog.gov.uk/page/", 2:67, "/"))
  
  testcat <- map(urls_all, function(x) get_blog_type(x, type = type))
  
  testdfcat <- map(testcat, as.data.frame)
  
  dtcat <- bind_rows(testdfcat) 
  
  dtcat %>%
    distinct()
  
}

