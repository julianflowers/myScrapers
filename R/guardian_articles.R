

## search Guardian for articles on wildlife conservation
## reads open data platform

guardian_eco <- function(n = 30, search){
  
library(guardianapi)
library(lubridate)
library(tidyverse)
  
search <- search

guardianapi::gu_api_key(check_env = TRUE)

last_month <- guardianapi::gu_content(search, from_date = today() - days(n), to_date = today())

glimpse(last_month)

last_month <- last_month %>%
  mutate(date = ymd(str_sub(web_publication_date, 1, 10))) %>%
  select(date, web_title, headline, body_text, short_url, section_name)

}

