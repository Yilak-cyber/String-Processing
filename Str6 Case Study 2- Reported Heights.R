##################################
# Case Study 2: Reported Heights #
##################################

#........................Key points.............................................

# In the raw heights data, many students did not report their height as the 
  # number of inches as requested. There are many entries with real height 
  # information but in the wrong format, which we can extract with string 
  # processing. 
# When there are both text and numeric entries in a column, the column will 
  # be a character vector. Converting this column to numeric will result in NAs 
# for some entries.
# To correct problematic entries, look for patterns that are shared across 
  # large numbers of entries, then define rules that identify those patterns and
  # use these rules to write string processing tasks.
# Use suppressWarnings() to hide warning messages for a function.
# load raw heights data and inspect 
#...............................................................................

library(tidyverse)
library(dslabs)
data(reported_heights)
view(reported_heights)
class(reported_heights$height)
# The height column of reported_heights dataset has a format of character

# convert to numeric, inspect, count NAs
y<-"3a"
as.numeric(y)
x <- as.numeric(reported_heights$height)
head(x)
sum(is.na(x)) # number of those which became NA when converted to numeric
# [1] 81
# keep only entries that result in NAs/ we added a new coloumn with numeric heights
reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height)) %>% 
  head(n=10)

# calculate cutoffs that cover 99.999% of human population
#1-0.99999=0.00001=1/10^6
alpha <- 1/10^6
qnorm(1-alpha/2, 69.1, 2.9) # 83.28575
qnorm(alpha/2, 63.7, 2.7) # 50.49258

# keep only entries that either result in NAs or are outside the plausible range of heights
not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}

# number of problematic entries
problems <- reported_heights %>% 
  filter(not_inches(height)) %>%
  .$height
length(problems)
#[1] 292

# 10 examples of x'y or x'y" or x'y\" (To be cvovered in the future)
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of x.y or x,y (To be cvovered in the future)
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat

# 10 examples of entries in cm rather than inches
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54, 54, 81) )
ind <- ind[!is.na(ind)]

problems[ind] %>% head(n=10) %>% cat


  23 2 3 2  3

regx=(inch|cm)
