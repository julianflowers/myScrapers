## Page visualisation highlighting keywords
## 
#

#' Visualise text pages with keywords highlighted as a page plot
#'
#' @param text 
#' @param keyword 
#' @param title 
#'
#' @return A page visualisation where selected keywords are highlighted
#' 
#'
#' @examples
#' 
#' page_viz(text, keyword = "fingertips", title = "Mentions of Fingertips in document")
#' 
page_viz <- function(text, keyword, title = "Title"){
  
  require(ggpage)
  
  ggpage_build(text) %>%
    mutate(long_word = stringr::str_detect(word, keyword)) %>%
    ggpage_plot(aes(fill = long_word)) +
    labs(title = "Title") +
    scale_fill_manual(values = c("grey70", "blue"),
                      labels = c( "text", keyword),
                      name = "Keyword")
}