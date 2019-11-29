## get of parliamentary questions and answers addressed to DHSC
## 


get_pqs_health <- function(start_date){
  if(!require(hansard))devtools::install_github("EvanOdell/hansard")
  require(hansard)
  require(dplyr)
  require(tibble)

  cat("Please wait...")
  
  dhsc2018 <- hansard_all_answered_questions(start_date = start_date, answering_body = "health and social care") 
  health_qn <- dhsc2018 %>%
    select(answer_date = date_of_answer_value, question_text,  answer_text = answer_text_value, answering_member = answering_member_printed_value,
                  hansard_category = hansard_heading_value) %>%
             mutate(answer_text = str_remove(answer_text, "\\<p\\>"))
  health_qn %>%
    as_tibble()
  
}



  