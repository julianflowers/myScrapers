## get semantic scholar abstracts
get_ss_data <- function(n = 100, search, journal = NULL){


  require(tidyverse)
  require(jsonlite)
  require(data.table)

  search_term <- str_replace_all(search, "\\s", "+")
  journal = journal

  uri <- glue::glue("https://api.semanticscholar.org/graph/v1/paper/search?query=", {search_term}, "&offset=10&limit=", n, "&fields=paperId,externalIds,title,abstract,year,venue,authors,url,referenceCount,citationCount,influentialCitationCount,isOpenAccess")


  df <- jsonlite::fromJSON(uri, simplifyDataFrame = TRUE)

  df <- list(data = as.data.table(df$data), url = uri)



}


greenfinch <- get_ss_data(search = "greenfinch")

glimpse(greenfinch)

paper <- greenfinch$data$paperId[40]

url <- glue::glue("https://api.semanticscholar.org/graph/v1/paper/", {paper}, "/citations?fields=title,authors,citationCount,referenceCount,influentialCitationCount,fieldsOfStudy,year,isOpenAccess")
df1 <- jsonlite::fromJSON(url, simplifyDataFrame = TRUE)

as.data.table(df1) %>%
  DT::datatable()
