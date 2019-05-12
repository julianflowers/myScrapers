# get page csv/xls


#' Find csv/xls(x) file links on a web page
#'
#' @param url 
#'
#' @return A list of links to csv/ xls(x) files
#' 
#'
#' @examples
#' url <- "https://fingertips.phe.org.uk"
#' csv <- get_page_csvs(url)
get_page_csvs <- function(url){
  
  require(httr)
  require(dplyr)
  require(rvest)
  
  csv <- GET(url) %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[grepl("csv$|xls.$", .)]
    
  
  return(csv)
  
}
