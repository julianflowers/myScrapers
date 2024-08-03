## get semantic scholar abstracts
get_ss_data <- function(n = 100, search, journal = NULL, api_key, mindate = 2020){


  require(tidyverse)
  require(jsonlite)
  require(data.table)

  search_term <- str_replace_all(search, "\\s", "+")
  journal = journal

  uri <- glue::glue("https://api.semanticscholar.org/graph/v1/paper/search/bulk?query=", {search_term}, "&", 
                    {api_key}, "&year=", {mindate}, "-",  "&offset=10&limit=", n, "&fields=paperId,externalIds,title,abstract,year,venue,authors,url,referenceCount,citationCount,influentialCitationCount,isOpenAccess")


  df <- jsonlite::fromJSON(uri, simplifyDataFrame = TRUE)

  df <- list(data = as.data.table(df$data), url = uri)



}


api_key <- Sys.getenv("SEMANTICSCHOLAR_API")
test <- get_ss_data(search = 'maternal mortality+saudi+arabia', api_key = api_key, mindate = 2010, n = 1000)
test$data[18]
