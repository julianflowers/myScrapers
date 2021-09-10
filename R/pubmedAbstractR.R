## function for downloading abstracts from pubmed

pubmedAbstractR <- function(search, n = 1000, ncbi_key = NA, start = 2000, end = end, db = "pubmed", keyword = FALSE, authors = FALSE, citations = FALSE){
  
  require(RISmed)
  require(dplyr)
  require(purrr)
  require(tibble)
  require(glue)
  
  search <- sprintf("%s&api_key=%s", gsub(" ", "+", search), 
                       ncbi_key)

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
                           journal = fetch@ISOAbbreviation,
<<<<<<< HEAD
                           doi = fetch@DOI, 
                          pmid = fetch@PMID, 
                          year = fetch@YearPubmed))
                         

=======
                           DOI = fetch@DOI,
                          pmid = fetch@PMID,
                           year = fetch@YearPubmed))
>>>>>>> d651dd6c5f36a0ceb07ae6f5042c32cc54afa7df
## add MeSH headings

if(keyword == TRUE){
mesh <- purrr::map(fetch@Mesh,  "Heading") %>%
  purrr::map(., data.frame) 

pmid -> names(mesh)

mesh <- mesh %>%
  bind_rows(., .id = "pmid") %>%
  rename(keyword = .x..i..) %>%
  data.frame()

abstracts <- left_join(abstracts, mesh) %>%
  group_by(title, abstract, journal, doi, year, pmid) %>%
  summarise(keyword = paste(keyword, collapse = ", "))
}
## add authors
if(authors == TRUE){
library(magrittr)
authors <- purrr::map(fetch@Author, extract,  c("LastName", "Initials", "order")) %>%
  purrr::map(., data.frame)


pmid <- fetch@PMID
pmid -> names(authors)

authors <- authors %>%
  bind_rows(., .id = "pmid") %>%
  data.frame()

## abstracts


abstracts <- left_join(abstracts, authors) 
}

## add citatons
  
if(citations == TRUE){
  citations <- purrr::map(fetch@Citations, "Reference") %>%
      purrr::map(., data.frame)
    
    
pmid <- fetch@PMID
    
    citations <- citations %>%
      bind_rows(., .id = "pmid") %>%
      data.frame() %>%
      select(pmid, citation = .x..i..) %>%
      mutate(citation = as.character(citation))
  
## abstracts


abstracts <- left_join(abstracts, citations, by = "pmid") %>%
  group_by(title, abstract, journal, doi, year, pmid) %>%
  summarise(citation = paste(citation, collapse = ", "))
}
## returns latest 1000 abstracts unless n value changed   
out <- list(abstracts = abstracts, n_articles = s1@count, search = s1@querytranslation)       
}



