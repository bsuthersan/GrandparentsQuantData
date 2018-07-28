##Script to get and clean data

library(tidyverse)
library(readxl)

##Function to clean data

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

##Get the data by year

####--------
##2017
###--------

##AGE

june2017age <- read_xls("June_2017.xls", sheet=2)
june2017age_no <- cleanfunction(june2017age, 5, 7:24, "_no")
june2017age_prop <- cleanfunction(june2017age, 5, 26:43, "_prop")
june2017age_error <- cleanfunction(june2017age, 5, 64:81, "_error")
remove(june2017age)

##INCOME

june2017income <- read_xls("June_2017.xls", sheet=5)
june2017income_no <- cleanfunction(june2017income, 5, 7:23, "_no")
june2017income_prop <- cleanfunction(june2017income, 5, 25:41, "_prop")
june2017income_error <- cleanfunction(june2017income, 5, 61:77, "_error")
remove(june2017income)

##HOURS

june2017hours <- read_xls("June_2017.xls", sheet=7)
june2017hours_no <- cleanfunction(june2017hours, 5, 7:23, "_no")
june2017hours_prop <- cleanfunction(june2017hours, 5, 25:41, "_prop")
june2017hours_error <- cleanfunction(june2017hours, 5, 61:77, "_error")
remove(june2017hours)

##Unite into a master

master2017 <- Reduce(function(...) merge(..., by="Care_Type", all=TRUE), 
              list(june2017age_no, june2017age_prop, june2017age_error,
                   june2017hours_no, june2017hours_prop, june2017hours_error,
                   june2017income_no, june2017income_prop, june2017income_error))

master2017 <- master2017 %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_2017")) %>%
  rename(Total_Children_No_No_2017 = `TOTAL CHILDREN_no.x_2017`,
         Total_Children_Prop_No_2017 = `TOTAL CHILDREN_prop.x_2017`,
         Total_Children_Error_No_2017 = `TOTAL CHILDREN_error.x_2017`,
         Total_Children_Hours_No_2017 = `TOTAL CHILDREN_no.y_2017`,
         Total_Children_Hours_Prop_2017 = `TOTAL CHILDREN_prop.y_2017`,
         Total_Children_Error_2017 = `TOTAL CHILDREN_error.y_2017`,
         Total_Children_Error_Error_2017 = `TOTAL CHILDREN_error_2017`)

##Remove all except master 2017

rm(list=ls()[! ls() %in% c("master2017", "cleanfunction")])

####--------
##2014
###--------

##AGE

june2014age <- read_xls("June_2014.xls", sheet=2)
june2014age_no <- cleanfunction(june2014age, 5, 7:24, "_no")
june2014age_prop <- cleanfunction(june2014age, 5, 26:43, "_prop")
remove(june2014age)

##INCOME

june2014income <- read_xls("June_2014.xls", sheet=7)
june2014income_no <- cleanfunction(june2014income, 5, 7:23, "_no")
june2014income_prop <- cleanfunction(june2014income, 5, 25:41, "_prop")
remove(june2014income)

##HOURS

june2014hours <- read_xls("June_2014.xls", sheet=9)
june2014hours_no <- cleanfunction(june2014hours, 5, 7:23, "_no")
june2014hours_prop <- cleanfunction(june2014hours, 5, 25:41, "_prop")
remove(june2014hours)

##Unite into a master

master2014 <- Reduce(function(...) merge(..., by = "Care_Type", all=TRUE), 
                     list(june2014age_no, june2014age_prop,
                          june2014hours_no, june2014hours_prop,
                          june2014income_no, june2014income_prop))

master2014 <- master2014 %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_2014")) %>%
  rename(Total_no_no_2014 = Total_no.x_2014,
         Total_no_prop_2014 = Total_prop.x_2014,
         Total_no_hours_2014=Total_no.y_2014,
         Total_prop_hours_2014=Total_prop.y_2014,
         Total_no_income_2014=Total_no_2014,
         Total_prop_income_2014=Total_prop_2014)

rm(list=ls()[! ls() %in% c("master2017", "master2014", "cleanfunction")])

####--------
##2011
###--------

##AGE

june2011age <- read_xls("June_2011.xls", sheet=2)
june2011age_no <- cleanfunction(june2011age, 5, 7:25, "_no")
june2011age_prop <- cleanfunction(june2011age, 5, 27:45, "_prop")
remove(june2011age)

##INCOME

june2011income <- read_xls("June_2011.xls", sheet=7)
june2011income_no <- cleanfunction(june2011income, 5, 7:23, "_no")
june2011income_prop <- cleanfunction(june2011income, 5, 25:41, "_prop")
remove(june2011income)

##HOURS

june2011hours <- read_xls("June_2011.xls", sheet=9)
june2011hours_no <- cleanfunction(june2011hours, 5, 7:23, "_no")
june2011hours_prop <- cleanfunction(june2011hours, 5, 25:41, "_prop")
remove(june2011hours)

master2011 <- Reduce(function(...) merge(..., by = "Care_Type", all=TRUE), 
                     list(june2011age_no, june2011age_prop,
                          june2011hours_no, june2011hours_prop,
                          june2011income_no, june2011income_prop))


master2011 <- master2011 %>%
  rename_at(vars(-Care_Type), function(x) paste0(x, "_2011")) %>%
  rename(Total_no_no_2011 = Total_no.x_2011,
         Total_no_prop_2011=Total_prop.x_2011,
         Total_hours_no_2011=Total_no.y_2011,
         Total_hours_prop_2011=Total_prop.y_2011,
         Total_income_no_2011=Total_no_2011,
         Total_income_prop_2011=Total_prop_2011)

rm(list=ls()[! ls() %in% c("master2017", "master2014", "master2011", "cleanfunction")])

##Merge into one master file

finalmaster <- master2017 %>%
  left_join(master2014, by = "Care_Type") %>%
  left_join(master2011, by = "Care_Type")

write.csv(finalmaster, "Data/Master.csv", row.names=F, na="")


