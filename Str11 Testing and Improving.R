
#########################
# Testing and Improving #
#########################

#........................Key points.............................................

# Wrangling with regular expressions is often an iterative process of testing 
# the approach, looking for problematic entries, and improving the patterns.
# Use the pipe to connect stringr functions.
# It may not be worth writing code to correct every unique problem in the data,
# but string processing techniques are flexible enough for most needs.
#...............................................................................
problems
# We have developed a powerful string processing technique that can help us 
 # catch many of the problematic entries.
# Now, it's time to test our approach, search for further problems,and tweak
 # our approach for possible improvements.
library(tidyverse)
library(dslabs)
library(stringr)
library(dslabs)
data(reported_heights)
# Let's write a function that captures all the entries that can't be converted
 # into numbers, remembering that some are in centimeters.
# We'll deal with those later.

# function to detect entries with problems
not_inches_or_cm <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- !is.na(inches) &
    ((inches >= smallest & inches <= tallest) |
       (inches/2.54 >= smallest & inches/2.54 <= tallest))
  !ind
}

view(reported_heights)
# identify entries with problems
problems <- reported_heights %>% 
  filter(not_inches_or_cm(height)) %>%
  .$height

# Let's see how many of these we can make fit our pattern after the several 
 # processing steps we have developed.

length(problems)
# 200

# Here, we leverage the pipe one of the advantages of using stringr.
# We use the pipe to concatenate the different replacements that we have 
 # just performed.
# Then we define the pattern and then, we go and try to see how many we match.

converted <- problems %>% 
  str_replace("feet|foot|ft", "'") %>% #convert feet symbols to '
  str_replace("inches|in|''|\"", "") %>%  #remove inches symbols
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") ##change format

# find proportion of entries that fit the pattern after reformatting
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
sum(index)
mean(index)
# We are matching more than half now. Let's examine the remaining cases.
# Here they are.
converted[!index]    # show problems

