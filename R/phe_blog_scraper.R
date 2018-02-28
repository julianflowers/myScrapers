## identify and download phe blogs


phe_blog_scraper <- function(category = category, n = 7L){
  
  require(rvest)
  require(stringr)
  require(tidyverse)
  
  n <- n  
  
  #stop(!category %in% )
  url_1 <- paste0("https://publichealthmatters.blog.gov.uk/category/", category, "/")
  url_2 <- paste0("https://publichealthmatters.blog.gov.uk/category/", category, "/page/", 2:n, "/")
  
  
  ## if there is only one page use n = 1 
  
  ifelse(n == 1, urls_comb <- url_1, urls_comb <- c(url_1, url_2))

  blog_df <- data.frame()
  
  for(i in seq_along(urls_comb)){
    
    
    page <- read_html(urls_comb[i]) %>%
      html_nodes("p")
    
    page2 <- html_text(page)%>%
      str_replace_all("\n", "")
    
    page2 <- bind_rows(page2)
    
    ifelse(!category %in% c("health-matters", "health-profile-for-england", "the-week-at-phe", "health-in-a-changing-climate", "cko/public-health-data-cko", "duncan-selbie-friday-message"), page3 <- page2[3:(length(page2)-3)], page3 <- page2[2:(length(page2)-3)]) 
    
    
    
    
    titles <- read_html(urls_comb[i]) %>%
      html_nodes(".entry-title")
    
    titles2 <- html_text(titles)
    
    date <- stringr::str_split(titles, pattern = "/")
    
    year <- map(date,  4)
    month <- map(date, 5)
    day <- map(date, 6)
    
    date1 <- paste(year, month, day, sep = "-")
    
    #test_titles <- read_html(urls_comb[i]) %>%
      #html_nodes(".entry-title")
    
    # title_dates <- read_html(urls_comb[i]) %>%
    #   html_nodes("a") %>%
    #   html_attr("href") %>%
    #   data.frame()
    # 
    # colnames(title_dates) <- "url"
    # 
    # dates <- title_dates %>%
    #   filter(!stringr::str_detect(url, "author")) %>%
    #   filter(!stringr::str_detect(url, "category")) %>%
    #   filter(!stringr::str_detect(url, "feed")) %>%
    #   filter(!stringr::str_detect(url, "public-health-matters")) %>%
    # 
    #   filter(stringr::str_detect(url, "publichealthmatters.blog.gov.uk/")) %>%
    #   separate(url, c("root", "l",  "link", "year", "month", "day", "other"), sep = "/") %>%
    #   select(year, month, day) %>%
    #   unite(date,  c("year", "month", "day"), sep = "-") %>%
    #   mutate(date = lubridate::ymd(date))

    blogs <- data.frame(title = titles2, text = page3, date = lubridate::ymd(date1), category = category) %>%
      mutate_if(is.factor, as.character)
    
    
    blog_df <- bind_rows(blog_df, blogs) %>% distinct()
    
    
  }
  
  blog_df
  
}     

