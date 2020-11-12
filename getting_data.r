library(janitor)
library(tidyverse)
library(httr)

#projectsearch-1572783843289.csv was downloaded from "research grant" filtered data on the Gateway to research portal, 3.11.2019
file <- "data/projectsearch-1572783843289.csv"
grants <- read.csv(file, 
                   stringsAsFactors = FALSE) %>% 
  clean_names()
grants <- grants_3.11.19

#adding abstracts
gtr_project_url <- grants$gtr_project_url

for (i in 1:length(gtr_project_url)) {
  gtr_request <- GET(gtr_project_url[i])
  results <- content(gtr_request)
  grants$abstract[i] <- results[["projectOverview"]][["projectComposition"]][["project"]][["abstractText"]]
}

file <- "data/grants_3-11-19.csv"
write.csv(grants, file)
