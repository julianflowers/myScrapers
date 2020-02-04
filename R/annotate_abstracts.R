## annotate abstracts

annotate_abstracts <- function(abstract, pmid){
  
  require(udpipe)
  
  ud_model <- udpipe_download_model("english")
  
  ud_model <- udpipe_load_model(ud_model$file_model)
  
  x <- udpipe_annotate(ud_model, x = out$abstracts$absText, doc_id = out$abstracts$pmid)
  x <- as.data.frame(x)
  x$topic_id <- unique_identifier(x, fields = c("doc_id", "paragraph_id", "sentence_id"))
  
  return(x)
  
}


