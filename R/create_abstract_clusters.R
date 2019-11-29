## create abstract clusters


create_abstract_cluster <- function(corpus, minPts = 20, perplexity = 50){
  
  cat("If there are a small number of abstracts, set perplexity value \nto less than 30% of abstract count")
  
  ## install packages
  if(!require(Rtsne))install.packages("Rtsne")
  if(!require(dbscan))install.packages("dbscan")
  if(!require(tictoc))install.packages("tictoc")

  require(tictoc)
  require(Rtsne)
  require(tictoc)
  require(dplyr)
  require(tibble)
  require(tidytext)
  
  tic()
  corpus <- corpus %>%
    filter(!is.na(pmid)) 
  
  pmid <- pull(corpus, "pmid") %>%
    unique() %>%
    enframe()
  
  tsne <- corpus %>%
    cast_sparse(pmid, word, tf_idf) %>%
    as.matrix() %>%
    Rtsne(check_duplicates = FALSE, perplexity = perplexity)
  
  plot <- tsne$Y %>%
    data.frame() %>%
    ggplot(aes(X1, X2)) +
    geom_point() +
    theme_void()
  
  set.seed(42)
  
  dbscan <- hdbscan(tsne$Y, minPts = minPts)

  hc_plot <- dbscan$hc %>%
    plot()
  
  clustering <- data.frame(cbind(pmid = pmid, tsne$Y, cluster = dbscan$cluster)) %>%
    mutate(V2 = as.numeric(as.character(X1)), 
           V3 = as.numeric(as.character(X2)))
  
  clustering <- clustering %>%
    mutate(clustered = ifelse(cluster == 0, "not-clustered", "clustered"))
  
  cluster_count <- length(unique(clustering$cluster))
  
  cluster_size <- clustering %>%
    count(cluster)
  
  toc()
  
  return <- list(tsne = tsne, plot = plot, dbscan = dbscan, corpus = corpus, clustering = clustering, cluster_count = cluster_count, cluster_size = cluster_size, hc_plot = hc_plot)


}


