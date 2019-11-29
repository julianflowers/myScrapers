## create cluster labels


create_cluster_labels <- function(corpus, clustering, top_n = 5){
  
  corpus <- corpus
  clustering <- clustering
  
  corpus <- corpus %>%
    filter(!is.na(pmid))
  
  labels <- clustering %>%
    left_join(corpus, by = c("pmid.value" = "pmid")) %>%
    group_by(cluster, word) %>%
    summarise(n = n(), meantf = mean(tf_idf), count = sum(n)) %>%
    top_n(top_n, count) %>%
    arrange(cluster, -meantf) %>%
    mutate(clus_names = paste0(word, collapse = "-")) %>%
    select(cluster, clus_names) %>%
    distinct()
  
  results <- clustering %>%
    left_join(labels)
  
  plotting_values <- results %>%
    dplyr::filter(clustered == "clustered") %>%
    group_by(clus_names, cluster) %>%
    dplyr::summarise(medX = median(V2, na.rm = TRUE), 
                     medY = median(V3, na.rm = TRUE))
  
  return <- list(labels = labels, plot = plotting_values, results = results)
  
  
  
}

