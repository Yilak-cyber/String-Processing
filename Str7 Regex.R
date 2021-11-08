#############
#    Regex  #
#############


#........................Key points............................................

# A regular expression (regex) is a way to describe a specific pattern of 
# characters of text. A set of rules has been designed to do this specifically 
# and efficiently.
# stringr functions can take a regex as a pattern.
# str_detect() indicates whether a pattern is present in a string.
# The main difference between a regex and a regular string is that a regex 
# can include special characters.
# The | symbol inside a regex means "or".
# Use '\\d' to represent digits. The backlash is used to distinguish it from 
# the character 'd'. In R, you must use two backslashes for digits in regular 
#expressions; in some other languages, you will only use one backslash for 
# regex special characters.
# str_view() highlights the first occurrence of a pattern, and the 
# str_view_all() function highlights all occurrences of the pattern.
#...............................................................................

#<<<<<<<<<<<<<<<<<<<<<<<<<<   Remember  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# During our previous discussion  on Case study 1: US murders data
# we defined murders_raw from the web scrapping
library(rvest)
url <- paste0("https://en.wikipedia.org/w/index.php?title=",
              "Gun_violence_in_the_United_States_by_state",
              "&direction=prev&oldid=810166167")
murders_raw <- read_html(url) %>%
  html_node("table") %>%
  html_table() %>%
  setNames(c("state", "population", "total", "murder_rate"))
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# load stringr through tidyverse
library(tidyverse)
library(dslabs)
data(reported_heights)
# detect whether a comma is present
head(reported_heights)
pattern <- ","
str_detect(murders_raw$total, pattern) 
str_detect(murders_raw$total, ",")

# show the subset of strings including "cm"

str_detect(murders_raw$total, "cm")
str_subset(reported_heights$height, "cm")

# use the "or" symbol inside a regex (|)
yes <- c("180 cm", "70 inches")
no <- c("180", "70''")
s <- c(yes, no)
str_detect(s, "cm") | str_detect(s, "inches")
str_detect(s, "cm|inches")

# highlight the first occurrence of a pattern
str_view(s, pattern)

str_view(s, "cm|inches")

# highlight all instances of a pattern
str_view_all(s, pattern)

#Additional Example

yes1 <- c("5", "6", "5'10", "5 feet", "4'11")
no1 <- c("", ".", "Five", "six")
s1 <- c(yes1, no1)
pattern1 <- "\\d"
str_detect(s1, pattern1)
str_view(s1, pattern1)
str_view_all(s1, pattern1)
