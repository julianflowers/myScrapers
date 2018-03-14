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
                      "By default 1000 abstracts are downloaded. You downloaded ", n, " abstracts. To retrieve more set 'n =' argument to the desired value")

print(comment)
  
fetch <- EUtilsGet(s1, type = "efetch", db = "pubmed")



#abstracts <- bibliometrix::pubmed2df(fetch)
  
DOI = fetch@PMID
abstracts <- as.tibble(cbind(title = fetch@ArticleTitle,
                          abstract = fetch@AbstractText,
                           journal = fetch@Title,
                           DOI,
                           year = fetch@YearPubmed))

mesh <- map(fetch@Mesh,  "Heading") %>%
  map(., data.frame) 

DOI -> names(mesh)

mesh <- mesh %>%
  bind_rows(., .id = "DOI") %>%
  rename(keyword = .x..i..) %>%
  data.frame()

abstracts <- left_join(abstracts, mesh)

## returns latest 1000 abstracts unless n value changed   
abstracts           
}


