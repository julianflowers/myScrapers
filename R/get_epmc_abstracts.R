## search europe PMC and return abstracts


get_epmc_abstracts <- function(search, limit = 1000, synonym = TRUE){
  
  if(!require("europepmc"))install.packages("europepmc")
  require(europepmc)
  require(dplyr)
  if(!require("tictoc"))install.packages("tictoc")
  require(tictoc)
  require(purrr)
  
  tic()
  search <- epmc_search(search, limit = limit, synonym = synonym)
  
  ids <- dplyr::pull(search, "id")
  ids <- ids %>%
    tibble::enframe()
  
  abstracts <- mutate(ids, abstract = purrr::map(value, epmc_details))
  
  abstracts <- abstracts %>%
    mutate(absText = purrr::map(abstract, "basic")) %>%
    mutate(absText = purrr::map(absText, "abstractText")) %>%
    select(-abstract)
  
  out <- search %>%
    left_join(abstracts, by = c("id" = "value"))
  
  out <- out %>%
    mutate(details = map(id, epmc_details), 
           mesh = map(details, "mesh_topic"), 
           mesh = map(mesh, "descriptorName")) %>%
    select(-details) %>%
    group_by(id) %>%
    mutate(keywords = paste(mesh, collapse = "; ")) %>%
    ungroup()
  
  toc <- toc()
  
  return <- list(df = out, tome = toc)
}

abs <- get_epmc_abstracts("GBD")

