## function for downloading abstracts from pubmed

pubmedAbstractR <- function(search, n = 1000, start = 2000, end = end, db = "pubmed"){
  
  require(RISmed)
  require(tidyverse)
  
  search <- search
  n <- n
  start <- start
  end <- end
  
s1 <- EUtilsSummary(search, 
                      type = "esearch", 
                      db = "pubmed",
                      datetype = "pdat",
                      retmax = n,
                      mindate = start, 
                      maxdate = end)
  
fetch <- EUtilsGet(s1, type = "efetch", db = "pubmed")
  
abstracts <- data.frame(title = fetch@ArticleTitle,
                          abstract = fetch@AbstractText, 
                          journal = fetch@Title,
                          DOI = fetch@PMID, 
                          year = fetch@YearPubmed) %>%
    mutate(abstract = as.character(abstract))

comment <- glue::glue("Your query is ", {s1@querytranslation}, ". This returns ", {s1@count}, " abstracts. ", 
           "By default 1000 abstracts are downloaded. To retrieve more set 'n =' argument to the desired value")


## returns latest 1000 abstracts unless n value changed   
print(comment)
abstracts           
}


