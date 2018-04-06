# get blog text

get_blog_text <- function(url){
  
  page <- read_html(url) %>%
    html_nodes(".entry-content") %>%
    html_text() %>%
    str_replace_all(., "\\n", "") %>%
    tm::stripWhitespace() %>%
    paste(.,  collapse = ";") %>%
    cbind(url)

  
}




