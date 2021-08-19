install.packages("guardianapi")
install.packages("reactable")
library(guardianapi)

https://open-platform.theguardian.com/
  
  

gu_api_key()

tags1 <- gu_tags(query = "wildlife")
#> Retrieving page 1


View(tags1)
tibble::glimpse(tags1)


rewilding <- gu_content(query = "rewilding", from_date = "2018-12-01",
                            to_date = "2020-12-31", tag = "environment")
#> Retrieving page 1

tibble::glimpse(rewilding)


rewilding %>%
  reactable::r
guardianapi::