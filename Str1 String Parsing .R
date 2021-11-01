##################
# String Parsing #
##################
# One of the most common data wrangling challenges involves
  # converting or extracting numeric data contained in character strings
  # into numeric representations required to make plots, summarize data, or fit
  # models in R 
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Key points
# ...............................

# The most common tasks in string processing include:
  # - extracting numbers from strings
  # - removing unwanted characters from text
  # - finding and replacing characters
  # - extracting specific parts of strings
  # - converting free form text to more uniform formats
  # - splitting strings into multiple values

# The stringr package in the tidyverse contains string processing functions that
# follow a similar naming format (str_functionname) and are compatible with the pipe.

# From the web scraping session, we recall that 
# html_node() extracts the first node.
# html_table() converts an HTML table to a data frame.
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

library(tidyverse) # which includes dplyr: a grammar of data manipulation
library(rvest) # helps to scrape (or harvest) data from web pages
library(stringr) # for string manipulation,

# read in raw murders data from Wikipedia
url <- "https://en.wikipedia.org/w/index.php?title=Gun_violence_in_the_United_States_by_state&direction=prev&oldid=810166167"
murders_raw <- read_html(url) %>% 
  html_nodes("table") %>% 
  html_table() %>%
  .[[1]] %>%
  setNames(c("state", "population", "total", "murder_rate"))

# inspect data and column classes
head(murders_raw)
class(murders_raw$population)
class(murders_raw$total)
# In two of the columns(population & total) 
   #numeric data is contained in character strings

