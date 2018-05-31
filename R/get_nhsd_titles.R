get_nhsd_titles <- function(link){
  
  csv_title <- link %>%
    read_html() %>%
    html_nodes(".attachment") %>%
    html_text() %>%
    .[grepl("CSV|Data File", .)] %>%
    tm::stripWhitespace()
  
  csv_title
}