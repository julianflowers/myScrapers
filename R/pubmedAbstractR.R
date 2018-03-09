## function for downloading abstracts from pubmed

pubmedAbstractR <- function(search, n = 1000, start = 2000, end = end, db = "pubmed"){
  
  require(RISmed)
  require(tidyverse)
  require(bibliometrix)
  
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

comment <- glue::glue("Please wait...Your query is ", {s1@querytranslation}, ". This returns ", {s1@count}, " abstracts. ", 
                      "By default 1000 abstracts are downloaded. You downloaded", n, " abstracts. To retrieve more set 'n =' argument to the desired value")

print(comment)
  
fetch <- EUtilsGet(s1, type = "efetch", db = "pubmed")

abstracts <- bibliometrix::pubmed2df(fetch)
  
# abstracts <- data.frame(title = fetch@ArticleTitle,
#                           abstract = fetch@AbstractText, 
#                           journal = fetch@Title,
#                           DOI = fetch@PMID, 
#                           year = fetch@YearPubmed) %>%
#     mutate(abstract = as.character(abstract))



## returns latest 1000 abstracts unless n value changed   
abstracts           
}


