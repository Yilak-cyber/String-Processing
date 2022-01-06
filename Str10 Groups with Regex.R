#####################
# Groups with Regex #
#####################

#........................Key points.............................................

# Groups are a powerful aspect of regex that permits the extraction of values.
# Groups are defined using parentheses.
# Once we define groups, we can use the function str_match() to extract the 
# values these groups define. str_extract() extracts only strings that match a 
# pattern, not the values defined by groups.
# You can refer to the ith group with \\i. For example, refer to the value in
# the second group with \\2.

#...............................................................................
library(tidyverse)
library(dslabs)
library(stringr)
library(dslabs)
data(reported_heights)
# 4. The second a large group of problematic entries were of 

# the form x.y or x,y, and x y.
# We want to change all these to our common format, x'y.
# But we can't just do the search and replace, because we would change value 
 # such as 70.5 into 70'5.

# Groups are a powerful aspect of regex that permits the extraction of values.
# They don't affect the pattern matching Instead, it permits tools to identify 
# specific parts of the pattern so we can extract them.
# So, for example, we want to change height like 5.6 to five feet, six inches.

# To avoid changing patterns such as 70.2, we'll require that the first digit 
 # be between four and seven
# we can do that using the range operation and that the second be 
 # none or more digits.
# We can do that using backslash, backslash d star.

# Let's start by defining a simple pattern that matches this.
# We can do it like this.

# define regex with and without groups
pattern_without_groups <- "^[4-7],\\d*$"
# We want to extract the digits so that we can then form the new version 
 # using a single quote.
# These are two groups, so we encapsulate them with parentheses like this.

pattern_with_groups <-  "^([4-7]),(\\d*)$"
# Note that we encapsulate the part of the pattern that matches the parts we 
 # want to keep, the parts we want to extract.

# Before we continue, notice that adding groups does not affect the detections 
# since it only signals that we want to save what is captured by the groups.
# We can see that by writing this code.
# create examples
yes <- c("5,9", "5,11", "6,", "6,1")
no <- c("5'9", ",", "2,8", "6.1.1")
s <- c(yes, no)

# demonstrate the effect of groups
str_detect(s, pattern_without_groups)
str_detect(s, pattern_with_groups)

# Note that the parentheses do not change the matching procedure.
# Once we define groups, we can use a function str_match to extract the values
 # these groups define, like this.

# demonstrate difference between str_match and str_extract
str_match(s, pattern_with_groups)
# Look what happens if we write this code.
# Note that the second and third columns contain feet and inches respectively.
# The first is the original pattern that was matched.
# If no match occurred, we see an N/A.

# Now we can understand the difference between the function str_extract
 # and str_match.
# str_extract extracts only strings that match a pattern, not the values 
 # defined by the groups.
# Here's what happens with string extract.
str_extract(s, pattern_with_groups)
# Another powerful aspect of groups is that you can refer to the extracted 
 # value in regex when searching and replacing.

# The regex special character for the i-th group is backslash, backslash, i.
# So backslash, backslash, 1 is the value extracted from the first group,
# and backslash, backslash, 2 is the value from the second group, and so on.

# So as a simple example, note that the following code will replace a 
# comma by a period, but only if it is between two digits.
# Here's the code.


# improve the pattern to recognize more events

pattern_with_groups <-  "^([4-7]),(\\d*)$"
yes <- c("5,9", "5,11", "6,", "6,1")
no <- c("5'9", ",", "2,8", "6.1.1")
s <- c(yes, no)
str_replace(s, pattern_with_groups, "\\1'\\2")

# We can use this to convert cases in our reported heights.
# Now we're ready to define a pattern that helps us convert all the x.y, x,y,
# and x y's to our preferred format.

# We need to adapt pattern underscore with groups to be a bit more flexible
 # and capture all these cases.
# The pattern now looks like this.

# final pattern
pattern_with_groups <-"^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$"

# Let's break this one down.# It's quite complicated.
# combine stringr commands with the pipe
# The caret means start of the string.
# Then four to seven means one digit between four and seven
  # four, five, six, or seven.
# Then the backslash, backslash, s, star means none or more white spaces.
# The next pattern means the feet symbol is either comma, or dot, or at least
# one space.
# Then we have none or more white spaces again.
# Then we have none or more digits, and then the end of the string.
# We can see that it appears to be working.


# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Remember >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# In a previous video, we defined the object problems containing the strings 
# that do not appear to be in inches.

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
pattern4 <- "^[4-7]\\s*'\\s*\\d{1,2}$"
problems %>% 
  str_replace("feet|ft|foot", "'") %>% # replace feet, ft, foot with ' 
  str_replace("inches|in|''|\"", "") %>% # remove all inches symbols
  str_detect(pattern4) %>% 
  sum()
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Let's try these examples.
str_subset(problems, pattern_with_groups) %>% head

# And we'll be able to perform the search and replace.
# Here we go. It almost has the desired outcome.

str_subset(problems, pattern_with_groups) %>% 
  str_replace(pattern_with_groups, "\\1'\\2") %>% head

# There's one little problem, and it's that we have one case with 25 inches.
# We'll deal with this problem later.
##<>??????
# Stopped before starting the video on 11/2/2021
##<>??????