## creates a data table of PHE stats and publications on .gov.uk

phe_catalogue <- function(url, pages = NULL) {
  
  
  
  library(Rcrawler)
  
  library(rvest)
  
  library(tidyverse)
  
  library(stringr)
  
  
  
  
  
  
  
  #url <- url
  
  uplinks<- paste0(url,  pages, "&publication_filter_option=statistics")
  
  
  
  pubs <- map(uplinks, Rcrawler::LinkExtractor)
  
  pubs_links <- map(pubs, 2)
  
  pubs_counts <-map(pubs_links, as.data.frame)
  
  
  
  uplink <- map(Rcrawler::LinkExtractor(url)[2], as.data.frame)
  
  phe_pubs  <- as.data.frame(rbind_list(pubs_counts, uplink) )
  
  
  
  
  
  
  
  colnames(phe_pubs) <- c("Links")
  
  
  
  phe_national_pubs <- phe_pubs %>%
    
    mutate(group = case_when(str_detect(Links, "collections/")~ "collections",
                             
                             str_detect(Links, "statistics/") ~ "statistics",
                             
                             str_detect(Links, "publications/") ~ "publication"),
           
           link = paste0("<a href =",  Links,  ">Links</a>"))
  
  
  
  #urls <- createLink(phe_national_pubs$Links[1:20])
  
  
  
  phe_national_pubs_table <- phe_national_pubs %>%
    
    filter(!is.na(group)) %>%
    
    DT::datatable(rownames = FALSE, escape = FALSE, extensions = 'Buttons', options = list(
      
      dom = 'Bfrtip',
      
      buttons = c('csv', 'excel', 'pdf')))
  
  
  
  
  
  return(phe_national_pubs_table) 
  
  
  
  
  
  
  
}



