## create search terms
## 
## 


#' Create a dictionary of terms to lookup in document-feature matrices
#'
#' @param ... 
#'
#' @return A dictionary of terms
#' 
#'
#' @examples
#' create_lookup(cars = c("Ford", "Mazda", "Lotus"))


create_lookup <- function(...){
  
  require(quanteda)
  
  dict <- dictionary(list(
    
    ...
    
    
  ))
  
  
}  
  
  

  
  
