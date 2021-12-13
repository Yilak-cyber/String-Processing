#################################
# Search and Replace with Regex #
#################################
# libraries
library(tidyverse) # which includes dplyr: a grammar of data manipulation
library(stringr) # for string manipulation,
library(dslabs)
data(reported_heights)
view(reported_heights)
data(reported_heights)
nrow(reported_heights)
#........................Key points.............................................


# str_replace() replaces the first instance of the detected pattern with a 
 # specified string.
# Spaces are characters and R does not ignore them. 
# Spaces are specified by the special character \\s.
# Additional quantifiers include *, + and ?. 
# * means 0 or more instances of the previous character. 
# ? means 0 or 1 instances. 
# + means 1 or more instances.
# Before removing characters from strings with functions like str_replace() 
# and str_replace_all(), consider whether that replacement would have 
# unintended effects.
#...............................................................................

#<<<<<<<<<<<<<<<<<<<<<<<<<<   Remember  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# In the previous sessions, we defined the object.....
# problems containing the strings that do not appear to be in inches. 


# number of problematic entries
# we defined a function to identify values less than 50 or greater than 84
  #  which 99.999% of human population
not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest
  ind
}
# we used our function to filter out values meeting the specified criteria 
problems <- reported_heights %>% 
   filter(not_inches(height)) %>%
 .$height
problems
# Total no of records 1095
length(problems)
#292
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# number of entries matching our desired pattern
pattern1 <- "^[4-7]'\\d{1,2}\"$"
str_detect(problems, pattern1)
sum(str_detect(problems, pattern1))# counts the number of problematic entrees
# 14
# We can see that only 14 of them match the pattern we defined.

problems
# To see why this is, we show examples that expose why we don't have more matches.
# Here are some examples.
# inspect examples of entries with problems
problems[c(2, 10, 11, 12, 15)] %>% str_view(pattern1)
cat(problems[c(2, 10, 11, 12, 15)])
# We see that only two of them match. Why is that?
  
 #1.A first problem we see immediately is that some students wrote out
 # the words feet and inches.
 # We can see the entries that did this with the function string subset
  #like this.

str_subset(problems, "inches")
 #2. some entries use the single quotes twice to represent inches instead of 
    # the double quotes.
    # We can see some examples using the string subset option.
str_subset(problems, "''")
# A first thing we can do to solve this problem is to replace the different 
  # ways of representing inches and feet with a uniform symbol.

# A first thing we can do to solve this problem is to replace the different
 # ways of representing inches and feet with a uniform symbol.
# We'll use a single quote for feet, and for inches, we'll simply not use anything.

# Now, if we no longer use the inches symbol at the end,
# we can change our pattern accordingly by taking it out of the pattern.
# So our pattern will be this then.
pattern2 <- "^[4-7]'\\d{1,2}$"
# remember our Old pattern was pattern1 <- "^[4-7]'\\d{1,2}\"$"
# If we do this replacement before the matching, we get many more matches.

# So we're going to use the string replace function to replace feet,ft, foot 
 # with the feet symbol.
# And we're going to replace inches in two single double quotes and slash 
 #double quotes with nothing.

problems %>% 
  str_replace("feet|ft|foot", "'") %>% # replace feet, ft, foot with ' 
  str_replace("inches|in|''|\"", "") %>% # remove all inches symbols
  str_detect(pattern2) %>% 
  sum()
#48

# We run this and now we see that we get many more matches.# 48
# However, we still have many cases to go.
# 3.Another problem we have are spaces.
# now we have identified 
# R does not ignore whitespace
identical("Hi", "Hi ")

# Now, if we no longer use the inches symbol at the end, we can change our 
 # pattern accordingly by taking it out of the pattern.So our pattern will be
# this then.

# \\s represents whitespace
# we don't need more than one regex pattern for the space and one without 
 # the space
# We can use quantifiers for this as well.
# So we want a pattern to permit spaces but not to require them.
# Even if there are several spaces , we will still want it to match.

# Additional quantifiers include *, + and ?. 
# * means 0 or more instances of the previous character. 
# ? means 0 or 1 instances. 
# + means 1 or more instances.

pattern3 <- "^[4-7]'\\s\\d{1,2}\"$"
str_subset(problems, pattern3)

# * means 0 or more instances of a character
yes <- c("AB", "A1B", "A11B", "A111B", "A1111B")
no <- c("A2B", "A21B")
str_detect(yes, "A1*B")
str_detect(no, "A1*B")

# test how *, ? and + differ
data.frame(string = c("AB", "A1B", "A11B", "A111B", "A1111B"),
           none_or_more = str_detect(yes, "A1*B"),
           nore_or_once = str_detect(yes, "A1?B"),
           once_or_more = str_detect(yes, "A1+B"))
# to improve our pattern, we can add the asterisks after the backslash, s 
 # in front and after the feet symbol to permit space between the feet
 # symbol and the numbers.

# update pattern by adding optional spaces before and after feet symbol
pattern4 <- "^[4-7]\\s*'\\s*\\d{1,2}$"
problems %>% 
  str_replace("feet|ft|foot", "'") %>% # replace feet, ft, foot with ' 
  str_replace("inches|in|''|\"", "") %>% # remove all inches symbols
  str_detect(pattern4) %>% 
  sum()

pattern_a <- "^[4-7]\\s*'\\s*\\d+$"

problems %>% 
  str_replace("feet|ft|foot", "'") %>% # replace feet, ft, foot with ' 
  str_replace("inches|in|''|\"", "") %>% # remove all inches symbols
  str_detect(pattern_a) %>% 
  sum()

"7'5\""
cat("7'5\"")
cat("7'5''")
#53
# Now we match and we get a few more entries.# 53
# We might be tempted to avoid doing this by removing all the spaces with the 
# function string replace all. However, when doing such an operation, 
# we need to make sure that it does not have some unintended effect.
# In our reported heights example, this will be a problem because some entries 
 # are of the form x space y with space




