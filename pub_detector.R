## publication detector idea
## given a report, can we detect its use or referencing in end user documents
## based on site: search in Google and search within documents
## use search term both for Google and search within documents


## try child health profiles....
## 


search <- "child health profile"
google <- googlesearchR(search, n = 20)

reports <- google[14] %>%
  as.character() %>%
  get_page_docs() %>%
  purrr::map(., ~(paste0("https://www.wirralintelligenceservice.org", .x))) 


downloads <- reports %>%
 unlist() %>%
  purrr::map(., ~(downloader::download(.x, basename(.x))))

here::here()

pdfs <- list.files(pattern = ".pdf")

pdfs_read <- readtext(pdfs)
pdfs_corpus <- corpus(pdfs_read, compress = TRUE)
pdfs_dfm <- dfm(pdfs_corpus, remove = stopwords("en"), remove_punct = TRUE, ngrams = c(1:3))

lu <- create_lookup(chp = "child_health_prof*")

lu1 <- dfm_lookup(pdfs_dfm, dictionary = lu) 

convert(lu1, to = "data.frame")

kwic(pdfs_corpus, phrase("child health profile")) %>%
  data.frame() %>%
  flextable::flextable(cwidth = 8, cheight = 1)
             