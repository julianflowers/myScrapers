## abstract topics

abstract_topics <- function(k = 10, x){
  
dtm <- document_term_frequencies(x, document = "topic_id", term = "term")
dtm <- document_term_matrix(x = dtm)
dtm <- dtm_remove_lowfreq(dtm, minfreq = 5)

m <- LDA(dtm, k = k, method = "Gibbs", 
         control = list(nstart = 5, burnin = 2000, best = TRUE, seed = 1:5))

topicterminology <- predict(m, type = "terms", min_posterior = 0.10, min_terms = 8)


scores <- predict(m, newdata = dtm, type = "topics", 
                  labels = paste("text", letters[1:k]))

out <- list(model = m, terms = topicterminology, scores = scores)

}


