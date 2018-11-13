## get of parliamentary questions and answers addressed to PHE
## 


get_pqs <- function(start_date){
  
  require(hansard)
  require(tidyverse)
  require(DT)
  
  cat("Please wait...")
  
  dhsc2018 <- hansard_all_answered_questions(start_date = start_date) %>% filter(str_detect(answering_body, "[Hh]ealth"))
  phe_qn <- filter(dhsc2018, str_detect(answer_text_value, "Public Health England|PHE")) %>%
    select(answer_date = date_of_answer_value, question_text,  answer_text = answer_text_value, answering_member = answering_member_printed_value,
           hansard_category = hansard_heading_value) %>%
    mutate(answer_text = str_remove(answer_text, "\\<p\\>"))
  
  phe_qn %>% as.tibble()
  
}


