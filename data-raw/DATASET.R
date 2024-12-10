## code to prepare `DATASET` dataset goes here

library(tidyverse)
data_weight <- read.csv("data-raw/mouse_data_weight.csv")
data_birth <- read.csv("data-raw/mouse_data_birth.csv")
nhanes <- read.csv("data-raw/nhanes1516.csv")
nhanes <- nhanes %>%
  mutate(female=as.factor(female)) %>%
  select(female, weight,systolic,diastolic,weight,height)

usethis::use_data(data_weight, overwrite = TRUE)
usethis::use_data(data_birth, overwrite = TRUE)
usethis::use_data(nhanes, overwrite = TRUE)

