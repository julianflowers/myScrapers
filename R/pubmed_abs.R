
library(myScrapers)
library(tidyverse)

test <- "(visualis* or visualiz*) and (medical record[mh] or 'electronic health record'[tw] or ehr[tw])"

end <- 2019

results <- pubmedAbstractR(search = test, end = end, n = 553)



results <- data.table::data.table(results)

View(results)



## remove blank abstracts
results <- results[, nchar := nchar(abstract) ][nchar > 0]


## create corpus
corpus <- results %>%
  tidytext::unnest_tokens(word, abstract, "words") %>%
  anti_join(tidytext::stop_words) %>%
  mutate(word = SnowballC::wordStem(word)) %>%
  count(DOI, word) %>%
  ungroup() %>%
  tidytext::bind_tf_idf(word, DOI, n)

dim(corpus)



## create dtm
library(Rtsne)

dtm <- tidytext::cast_dtm(corpus, DOI, word, tf_idf) 


## run Rtsne
Rtsne <- Rtsne(as.matrix(dtm), check_duplicates = FALSE, num_threads = 6)

plot(Rtsne$Y, pch = 16)


## run dbscan
library(dbscan)

clusters <- hdbscan(Rtsne$Y, minPts = 5)


clusters <- data.table::data.table(clusters$cluster)

## number and size of clusters
clusters[, .N, by = .(V1)][order(V1)]

## data frame
out <- data.frame(Rtsne$Y, clusters, results$DOI, results$year)


## clustered or not
clustered <- out %>%
  mutate(clustered = ifelse(clusters == 0, "not-clustered", "clustered")) 

## cluster medians
clusterNames <- clustered %>%
  dplyr::group_by(V1) %>%
  dplyr::summarise(medX = median(X1),
                   medY = median(X2)) %>%
  dplyr::filter(V1 != 0)


## labels

labels <- clustered %>%
  mutate(DOI = as.character(results.DOI)) %>%
  inner_join(corpus) %>%
  group_by(V1, word) %>%
  summarise(n = n(), mean_tf = mean(tf_idf)) %>%
  top_n(5, n) %>%
  arrange(V1, -mean_tf) %>%
  slice(1:5) %>%
  mutate(label = paste0(word, collapse = "-")) %>%
  select(V1, label) %>%
  distinct()


clusterNames <- clusterNames %>%
  inner_join(labels)

## plots
library(ggrepel)
ggplot(clustered,aes(x=X1,y=X2,group=V1))+
  geom_point(aes(colour = clustered),alpha=0.2)+
  geom_label_repel(data=clusterNames,aes(x=medX,y=medY,label=label),size=2,colour="red")+
  stat_ellipse(aes(alpha=clustered))+
  scale_colour_manual(values=c("black","blue"),name="cluster status")+
  scale_alpha_manual(values=c(1,0),name="cluster status")+ #remove the cluster for noise
  theme_bw() +
  ggsave("cluster_plot.png")

out1 <- out %>%
  mutate(DOI = as.character(results.DOI)) %>%
  inner_join(results)

data.table::setDT(out1)[V1 != 0, .N, by = .(V1, results.year)] %>%
  ggplot(aes(results.year, N, fill = factor(V1))) +
  geom_col(position = "fill") +
  viridis::scale_fill_viridis(discrete = TRUE, direction = -1) +
  coord_flip() +
  ggsave("cluster_trend.png")
