library(tidyverse)

download_brasilio_table <- function(dataset, table_name){
  url <- sprintf(
    "https://data.brasil.io/dataset/%s/%s.csv.gz", dataset, table_name
  )
  tmp <- tempfile()
  download.file(url, tmp)
  response <- read.csv(gzfile(tmp), encoding = "UTF-8")
  unlink(tmp)
  return(response)
}

# Passe o nome da tabela para a funcao, como "caso", "caso_full",
# "obito_cartorio":

download_brasilio_table("covid19", "caso_full") %>%
  filter(place_type == "state") %>%
  group_by(date) %>%
  summarize(
    new_confirmed = sum(new_confirmed),
    new_deaths = sum(new_deaths)
  ) %>%
  mutate(
    date = as.Date(date),
    ma_conf = zoo::rollmean(new_confirmed, k = 7, fill = NA, align = "right"),
    ma_deaths = zoo::rollmean(new_deaths, k = 7, fill = NA, align = "right"),
  ) %>%
  ungroup() %>%
  data.frame() %>%
  write.csv(file = here::here("data","treated-data.csv"), row.names = F)
