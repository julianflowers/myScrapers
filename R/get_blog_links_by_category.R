get_blog_links_by_category <- function(url, category, pages = 1){ 
  pages <- pages
  url <- paste0(url, category, "/")
  url1 <- paste0(url, category, "/page/", pages)
  ifelse(pages >1, urls <- c(url, url1), urls <- url)
  
  page <- read_html(urls) %>%
    html_nodes("a") %>%
    html_attr("href")
  
  page <- page[!grepl("author", page)]
  page <- page[!grepl("category", page)]
  page <- page[!grepl("subscribe", page)]
  page <- page[!grepl("https://www.blog.gov.uk", page)]
  page <- page[!grepl("www.gov.uk", page)]
  page <- page[!grepl("nationalarchives", page)]
  page <- page[!grepl("twitter", page)]
  page <- page[!grepl("facebook", page)]
  page <- page[!grepl("youtube", page)]
  page <- page[!grepl("content", page)]
  page <- page[!grepl("https://blog.gov.uk", page)]
  page <- page[!grepl("feed", page)]
  page <- page[!grepl("public-health-matters", page)]
  
  
}

