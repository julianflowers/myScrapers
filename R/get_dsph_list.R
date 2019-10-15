

#' Get a list of Directors of Public Health in England
#'
#' @param url 
#'
#' @return A dataframe of local authority districts and their current Director of Public Health
#' 
#'
#' @examples
#' 
#' dsph <- get_dsph_england()
#' 
get_dsph_england<- function(url = "https://www.gov.uk/government/publications/directors-of-public-health-in-england--2/directors-of-public-health-in-england"){
  
  require(rvest)
  require(dplyr)
  url <- url
  
  dsph <- get_page_text(url) %>%
    .[14:165] %>%
    data.frame() 
  
  # dsph <- dsph %>%
  #   html_nodes("p") %>%
  #   html_text() 
  
  
  colnames(dsph) <- "data"
  
  dsph <- dsph %>%
    mutate(data = str_replace(data, "Tameside", "Tameside -")) %>%
    mutate(data = str_replace(data, "- -", "-")) %>%
    mutate(data = str_replace(data, "–  Wendy", "- Wendy")) %>%
    mutate(data = str_replace(data, " -Imran", " - Imran")) %>%
    mutate(data = str_replace(data, "--", "-")) %>%
    mutate(data = str_replace(data, "Sussex ", "Sussex - ")) %>%
    #mutate(data = str_replace(data, "Meredith \\(actin", "Meredith \\(acting")) %>%
    separate(data, c("LA", "Name"), sep = " - ")
  
}




  
