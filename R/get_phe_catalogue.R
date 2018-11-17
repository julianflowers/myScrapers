


## creates a data table of PHE stats and publications on .gov.uk




get_phe_catalogue <- function(url = "https://www.gov.uk/government/publications?departments%5B%5D=public-health-england", pages = 2:n, n=91) {
  
  library(Rcrawler)

  library(rvest)
  
  library(tidyverse)
  
  library(stringr)
  

  
  first_page <- url
  
  sub_pages <- paste0(first_page,"&page=", 2:n)    
  
  #url <- url
  
  pubs <- map(sub_pages, Rcrawler::LinkExtractor)
  
  pubs <- map(pubs, 2) 
  
  pubs <-map(pubs, as.data.frame)
  
  uplink <- map(Rcrawler::LinkExtractor(first_page)[2], as.data.frame)

  
  phe_pubs  <- as.data.frame(bind_rows(pubs, uplink) )

  
  colnames(phe_pubs) <- c("Links")
 
  
  phe_pubs <- phe_pubs %>%
  distinct()
  

  
  phe_national_pubs <- phe_pubs %>%
    mutate(group = case_when(str_detect(Links, "collections/")~ "collections", 
                           str_detect(Links, "statistics/") ~ "statistics",
                           str_detect(Links, "publications/") ~ "publication"), 
         link = paste0("<a href =",  Links,  ">Links</a>"))

  
  phe_national_pubs_table <- phe_national_pubs %>%
    filter(!is.na(group)) %>%
    DT::datatable(rownames = FALSE, escape = FALSE, extensions = 'Buttons', options = list(
    dom = 'Bfrtip',
    buttons = c('csv', 'excel', 'pdf')))

  return(phe_national_pubs_table)  

  
}


