## get of parliamentary questions and answers addressed to PHE
## 


get_phe_pqs <- function(start_date){
  
  if(!require(hansard))devtools::install_github("EvanOdell/hansard")
  require(hansard)
  require(tidyverse)
  require(dplyr)

  cat("Please wait...")
  
  dhsc2018 <- all_answered_questions(start_date = start_date, answering_body = "health and social care") 
  
  phe_qn <- dplyr::filter(dhsc2018, str_detect(answer_text_value, "Public Health England|PHE")) %>%
    dplyr::select(answer_date = date_of_answer_value, question_text,  answer_text = answer_text_value, answering_member = answering_member_printed_value,
           hansard_category = hansard_heading_value) %>%
    mutate(answer_text = str_remove(answer_text, "\\<p\\>")) %>%
    distinct()
  
  phe_qn %>% as.tibble()
  
}

