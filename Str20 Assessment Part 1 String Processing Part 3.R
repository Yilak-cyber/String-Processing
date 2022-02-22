# Str 15 Assessment Part 1: String Processing Part 3
library(tidyverse) # which includes dplyr: a grammar of data manipulation
library(stringr) # for string manipulation,
library(dslabs)

# ......................Question 1........................

# You have the following table, schedule:
# schedule
# day		staff
# Monday		Mandy, Chris and Laura
# Tuesday		Steve, Ruth and Frank


# You want to turn this into a more useful data frame.

# Which two commands would properly split the text in the "staff" column 
 # into each individual name? Select ALL that apply.
# let us conver this into a table

day<-c("Monday","Tuesday")
staff<-c("Mandy, Chris and Laura","Steve, Ruth and Frank")

schedule<-data.frame(day=day, staff=staff)
schedule
# Choice1 
str_split(schedule$staff, ",|and")
# Choice2 
str_split(schedule$staff, ", | and ")
# Choice3
str_split(schedule$staff, ",\\s|\\sand\\s")
# Choice4
str_split(schedule$staff, "\\s?(,|and)\\s?")

# Answer Choice2 & Choice3

# ......................Question 2........................

# You have the following table, schedule:
# schedule
# day		staff
# Monday		Mandy, Chris and Laura
# Tuesday		Steve, Ruth and Frank
# What code would successfully turn your "Schedule" table into the following 
 # tidy table?

# tidy

# day     staff
# <chr>   <chr>

# Monday  Mandy
# Monday  Chris
# Monday  Laura
# Tuesday Steve
# Tuesday Ruth 
# Tuesday Frank
schedule
# Choice1
tidy1 <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ")) %>% 
  unnest(staff)

tidy1 # can be answer
# Choice2
tidy2 <- separate(schedule, staff, into = c("s1","s2","s3"), sep = ",") %>% 
  gather(key = s, value = staff, s1:s3)
tidy2 # can not be answer
# Choice3
tidy3 <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ", simplify = TRUE)) %>% 
  unnest(staff)
tidy3 # can not be answer
# Answer Choice1

# ......................Question 3........................

# Using the gapminder data, you want to recode countries longer than 12 letters
 # in the region "Middle Africa" to their abbreviations in a new column, 
 # "country_short". Which code would accomplish this?

# Choice1
dat_a <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(recode(country, 
                "Central African Republic" = "CAR", 
                "Congo, Dem. Rep." = "DRC",
                "Equatorial Guinea" = "Eq. Guinea"))
head(dat_a)

# Choice2
dat_b <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
      c("Central African Republic", "Congo, Dem. Rep.", "Equatorial Guinea"),
      c("CAR", "DRC", "Eq. Guinea")))

head(dat_b)

# Choice3
dat_c <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country = recode(country, 
                          "Central African Republic" = "CAR", 
                          "Congo, Dem. Rep." = "DRC",
                          "Equatorial Guinea" = "Eq. Guinea"))

head(dat_c)

# Choice4
dat_d <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))

head(dat_d)

# Answer Choice4