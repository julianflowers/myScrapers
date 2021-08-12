## get semantic scholar abstracts
get_ss_data <- function(n = 100, search){


  require(tidyverse)
  require(jsonlite)
  require(data.table)

  search_term <- str_replace_all(search, "\\s", "+")

  uri <- glue::glue("https://api.semanticscholar.org/graph/v1/paper/search?query=", {search_term}, "&offset=10&limit=", n, "&fields=paperId,externalIds,title,abstract,year,venue,authors,url,referenceCount,citationCount,influentialCitationCount,isOpenAccess")


  df <- jsonlite::fromJSON(uri, simplifyDataFrame = TRUE)

  df <- list(data = as.data.table(df$data), url = uri)



}


