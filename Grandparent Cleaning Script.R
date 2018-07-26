library(tidyverse)
library(readxl)

##Read in age data from ABS

june2017age <- read_xls("~/Documents/GrandparentsProject/June_2017.xls", sheet=2)

##PART 1: AGE DATA

june2017age <- june2017age[5:81, ]
colnames(june2017age) <- june2017age[1, ]
colnames(june2017age)[1] <- "Care_Type"

##Split the data based on numbers, proportion, and error

june2017age_no <- june2017age[3:20, ]
june2017age_prop <- june2017age[22:39, ]
june2017age_error <- june2017age[60:77,]

##Rename columns

june2017age_no <- june2017age_no %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_no"))
june2017age_prop <- june2017age_prop %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_prop"))
june2017age_error <- june2017age_error %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_error"))

#Merge into master

master <- june2017age_no %>%
  left_join(june2017age_prop, by = "Care_Type") %>%
  left_join(june2017age_error, by = "Care_Type")

#Remove left over data

rm(list=setdiff(ls(), "master"))

##PART 2: INCOME

june2017income <- read_xls("~/Documents/GrandparentsProject/June_2017.xls", sheet=5)

colnames(june2017income) <- june2017income[5, ]
colnames(june2017income)[1] <- "Care_Type"

##Split the data based on numbers, proportion, and error

june2017income_no <- june2017income[5:22, ]
june2017income_prop <- june2017income[25:40, ]
june2017income_error <- june2017income[61:76, ]

##Rename columns

june2017income_no <- june2017income_no %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_no"))
june2017income_prop <- june2017income_prop %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_prop"))
june2017income_error <- june2017income_error %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_error"))

##Merge into master

master <- master %>%
  left_join(june2017income_no, by = "Care_Type") %>%
  left_join(june2017income_prop, by = "Care_Type") %>%
  left_join(june2017income_error, by = "Care_Type")

#Remove left over data

rm(list=setdiff(ls(), "master"))

##PART THREE: HOURS OF CARE

june2017hour <- read_xls("~/Documents/GrandparentsProject/June_2017.xls", sheet=7)

colnames(june2017hour) <- june2017hour[5, ]
colnames(june2017hour)[1] <- "Care_Type"

##Split the data based on numbers, proportion, and error

june2017hour_no <- june2017hour[9:22, ]
june2017hour_prop <- june2017hour[27:40, ]
june2017hour_error <- june2017hour[63:76, ]

##Rename columns

june2017hour_no <- june2017hour_no %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_no"))
june2017hour_prop <- june2017hour_prop %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_prop"))
june2017hour_error <- june2017hour_error %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_error"))

##Merge into master
master <- master %>%
  left_join(june2017hour_no, by = "Care_Type") %>%
  left_join(june2017hour_prop, by = "Care_Type") %>%
  left_join(june2017hour_error, by = "Care_Type")

#Remove left over data

rm(list=setdiff(ls(), "master"))

