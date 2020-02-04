## abstract topic visualisation


abstract_topic_viz <-function(x, m, scores, n = 1){


library(igraph)
library(ggraph)
library(ggplot2)
library(qgraph)

scores <- scores %>%
  mutate(doc_id = as.numeric(doc_id))

x_topic <- np %>% left_join(scores, by = c("topic_id" = "doc_id"))
topicterminology <- predict(m, type = "terms", min_posterior = 0.05, min_terms = 20)
termcorrs <- subset(x_topic, topic %in% n & lemma %in% topicterminology[[n]]$term)
termcorrs <- document_term_frequencies(termcorrs, document = "topic_id", term = "lemma")
termcorrs <- document_term_matrix(termcorrs)
termcorrs <- dtm_cor(termcorrs)
termcorrs[lower.tri(termcorrs)] <- NA
diag(termcorrs) <- NA
library(qgraph)
qgraph(termcorrs, layout = "spring", labels = colnames(termcorrs), directed = FALSE,
       borders = FALSE, label.scale = FALSE, label.cex = 1, node.width = 0.5)

}

