
## clean up text

#' Clean texts by changing to lower case and removing stopwords, numbers, punctuation and white space
#'
#' @param text A text to be cleaned
#'
#' @return A clean text
#' 
#'
#' @examples
#' clean_text(text)

clean_texts <- function(text){
  
  require(tm)
  
  text <- tolower(text)
  text <- tm::removeWords(text, stopwords("en"))
  text <- tm::removeNumbers(text)
  text <- tm::removePunctuation(text)
  text <- tm::stripWhitespace(text)
  
}
