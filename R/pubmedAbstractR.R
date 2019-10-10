## function for downloading abstracts from pubmed

pubmedAbstractR <- function(search, n = 1000, start = 2000, end = end, db = "pubmed", keyword = FALSE, authors = FALSE){
  
  require(RISmed)
  require(dplyr)
  require(purrr)
  require(tibble)
  require(glue)
  
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
abstracts <- as_tibble(cbind(title = fetch@ArticleTitle,
                          abstract = fetch@AbstractText,
                           journal = fetch@Title,
                           DOI,
                           year = fetch@YearPubmed))
## add MeSH headings

if(keyword == TRUE){
mesh <- purrr::map(fetch@Mesh,  "Heading") %>%
  purrr::map(., data.frame) 

DOI -> names(mesh)

mesh <- mesh %>%
  bind_rows(., .id = "DOI") %>%
  rename(keyword = .x..i..) %>%
  data.frame()

abstracts <- left_join(abstracts, mesh)
}
## add authors
if(authors == TRUE){
library(magrittr)
authors <- purrr::map(fetch@Author, extract,  c("LastName", "Initials", "order")) %>%
  purrr::map(., data.frame)


DOI = fetch@PMID
DOI -> names(authors)

authors <- authors %>%
  bind_rows(., .id = "DOI") %>%
  data.frame()

## abstracts


abstracts <- left_join(abstracts, authors)
}
## returns latest 1000 abstracts unless n value changed   
out <- list(abstracts = abstracts, n_articles = s1@count, search = s1@querytranslation)       
}





