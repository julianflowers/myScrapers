

get_dsph_england <- function(url){
  
  suppressWarnings(require(tidyverse)); require(rvest)
  url <- "https://www.gov.uk/government/publications/directors-of-public-health-in-england--2/directors-of-public-health-in-england"
  
  dsph <- read_html(url)
  
  dsph <- dsph %>%
    html_nodes("p") %>%
    html_text() %>%
    .[10:161] %>%
    data.frame() 
  
  
  colnames(dsph) <- "data"
  
  dsph <- dsph %>%
    mutate(data = str_replace(data, "Tameside", "Tameside -")) %>%
    mutate(data = str_replace(data, "–  Wendy", "- Wendy")) %>%
    mutate(data = str_replace(data, " -Imran", " - Imran")) %>%
    mutate(date = str_replace(data, "Sussex -", "Sussex ")) %>%
    #mutate(data = str_replace(data, "Meredith \\(actin", "Meredith \\(acting")) %>%
    separate(data, c("LA", "Name"), sep = " - ")
  
}

dsph <- get_dsph_england()
dsph
