library(tidyverse)
library(readxl)

cleanfunction <- function(data, colnam, y, dataname) {
  ##Assign colnames
  colnames(data) <- data[colnam, ]
  colnames(data)[1] <- "Care_Type"
  ##Subset data
  data <- data[y, ]
  ##Assign a unique name depending on type of data
  data <- data %>%
    rename_at(vars(-Care_Type), function(x) paste0(x, dataname))
  return(data)
}

####--------
##2014
###--------

##AGE

june2014age <- read_xls("~/Documents/June_2014.xls", sheet=2)
june2014age_no <- cleanfunction(june2014age, 5, 7:24, "_no")
june2014age_prop <- cleanfunction(june2014age, 5, 26:43, "_prop")
remove(june2014age)

##INCOME

june2014income <- read_xls("~/Documents/June_2014.xls", sheet=7)
june2014income_no <- cleanfunction(june2014income, 5, 7:23, "_no")
june2014income_prop <- cleanfunction(june2014income, 5, 25:41, "_prop")
remove(june2014income)

##HOURS

june2014hours <- read_xls("~/Documents/June_2014.xls", sheet=9)
june2014hours_no <- cleanfunction(june2014hours, 5, 7:23, "_no")
june2014hours_prop <- cleanfunction(june2014hours, 5, 25:41, "_prop")
remove(june2014hours)


####--------
##2011
###--------

##AGE

june2011age <- read_xls("~/Documents/June_2011.xls", sheet=2)
june2011age_no <- cleanfunction(june2011age, 5, 7:25, "_no")
june2011age_prop <- cleanfunction(june2011age, 5, 27:45, "_prop")
remove(june2011age)

##INCOME

june2011income <- read_xls("~/Documents/June_2011.xls", sheet=7)
june2011income_no <- cleanfunction(june2011income, 5, 7:23, "_no")
june2011income_prop <- cleanfunction(june2011income, 5, 25:41, "_prop")
remove(june2011income)

##HOURS

june2011hours <- read_xls("~/Documents/June_2011.xls", sheet=9)
june2011hours_no <- cleanfunction(june2011hours, 5, 7:23, "_no")
june2011hours_prop <- cleanfunction(june2011hours, 5, 25:41, "_prop")
remove(june2011hours)


