## topic model with nounphrases

abstract_nounphrases <- function(x){
  
  require(udpipe)
  
  x$phrase_tag <- as_phrasemachine(x$upos, type = "upos")
  
  keyw_nounphrases <- keywords_phrases(x$phrase_tag, term = x$token, 
                                       pattern = "(A|N)*N(P+D*(A|N)*N)*", is_regex = TRUE, 
                                       detailed = FALSE)
  keyw_nounphrases <- subset(keyw_nounphrases, ngram > 1)
  
  ## Recode terms to keywords
  x$term <- x$token
  keyw_nounphrases <- keywords_phrases(x$phrase_tag, term = x$token, 
                                       pattern = "(A|N)*N(P+D*(A|N)*N)*", is_regex = TRUE, 
                                       detailed = FALSE)
  keyw_nounphrases <- subset(keyw_nounphrases, ngram > 1)
  
  ## Recode terms to keywords
  x$term <- x$token
  
  x$term <- txt_recode_ngram(x$term, 
                             compound = keyw_nounphrases$keyword, ngram = keyw_nounphrases$ngram)
  x$term <- ifelse(x$upos %in% "NOUN", x$term,
                   ifelse(x$term %in% c(keyw_nounphrases$keyword), x$term, NA))
  
  return(x)
  
}


