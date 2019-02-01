clean_texts <- function(text){
  
  require(tm)
  
  text <- tolower(text)
  text <- tm::removeWords(text, stopwords("en"))
  text <- tm::removeNumbers(text)
  text <- tm::removePunctuation(text)
  text <- tm::stripWhitespace(text)
  
}
