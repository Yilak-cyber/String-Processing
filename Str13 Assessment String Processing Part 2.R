#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Required Libraries 
library(tidyverse)
library(stringr)
# Assessment: String Processing Part 2

#.................................Question 1................................

# In the video, we use the function not_inches to identify heights that were 
# incorrectly entered
# In this function, what TWO types of values are identified as not being 
#correctly formatted in inches?
not_inches <- function(x, smallest = 50, tallest = 84) {
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < smallest | inches > tallest 
  ind
}

# Example
x<-c(2,"3","4 inches","5'")
y<-c("40","55","60","80","95")
suppressWarnings(as.numeric(x))
z<-c(x,y)
not_inches(z)

# Answer:
# Values that result in NA's when converted to numeric
# Values less than 50 inches or greater than 84 inches
#.................................Question 2................................

# Which of the following arguments, when passed to the function not_inches(),
# would return the vector c(FALSE)?
not_inches(c(175))    #TRUE
not_inches(c("5'8\""))     #Error
not_inches(c(70))   # FALSE
not_inches(c(85))  #TRUE

# Answer:      not_inches(c(70))   

#.................................Question 3................................

# Our function not_inches() returns the object ind. Which answer correctly 
# describes ind?

# Answer: 
# ind is a logical vector of TRUE and FALSE, equal in length to the vector x
# (in the arguments list). TRUE indicates that a height entry is incorrectly
# formatted.

#.................................Question 4................................

# Given the following code
# > s
# [1] "70"       "5 ft"     "4'11"     ""         "."        "Six feet"
# What pattern vector yields the following result?
str_view_all(s, pattern)
# 70
# 5 ft
# 4'11
# .
# Six feet

s<-c("70","5 ft","4'11", "", ".", "Six feet")
# option1
pattern1 <- "\\d|ft"
str_view_all(s, pattern1) # Yes
# option2
pattern2 <- "\d|ft" # Error
str_view_all(s, pattern2)
# option3
pattern3 <- "\\d\\d|ft" # NO
str_view_all(s, pattern3)
# option4
pattern4 <- "\\d|feet" # No
str_view_all(s, pattern4)

# Answer: # option1
pattern <- "\\d|ft"

#.................................Question 5................................

# You enter the following set of commands into your R console. 
# What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]"
str_detect(animals, pattern)

# Answer:
# TRUE TRUE TRUE FALSE

#.................................Question 6................................

# You enter the following set of commands into your R console. 
 # What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[A-Z]$"
str_detect(animals, pattern)
str_detect(animals, "^[A-Z]")
# Answer:
# FALSE FALSE FALSE TRUE

#.................................Question 7................................
# You enter the following set of commands into your R console. 
# What is your printed result?
animals <- c("cat", "puppy", "Moose", "MONKEY")
pattern <- "[a-z]{4,5}"
str_detect(animals, pattern)

# Answer:
# FALSE  TRUE  TRUE FALSE

#.................................Question 8................................

# Given the following code:
animals <- c("moose", "monkey", "meerkat", "mountain lion")
# Which TWO "pattern" vectors would yield the following result?
str_detect(animals, pattern)
#  TRUE TRUE TRUE TRUE

# option1
pattern_a <- "mo*"     # TRUE TRUE TRUE TRUE 
str_detect(animals, pattern_a)
# option2
pattern_b <- "mo?"    # TRUE TRUE TRUE TRUE
str_detect(animals, pattern_b)
# option3
pattern_c <- "mo+"    # TRUE  TRUE FALSE  TRUE
str_detect(animals, pattern_c)
# option4
pattern_d <- "moo*"   # TRUE  TRUE FALSE  TRUE
str_detect(animals, pattern_c)

# Answer:option1 & option2

#.................................Question 9................................

#You are working on some data from different universities. 
# You have the following vector:
# > schools
# [1] "U. Kentucky"  "Univ New Hampshire"  "Univ. of Massachusetts" "University Georgia"         
# [5] "U California"   "California State University"
# You want to clean this data to match the full names of each university:
# > final
# [1] "University of Kentucky" "University of New Hampshire" 
# "University of Massachusetts" "University of Georgia"         
# [5] "University of California"  "California State University"

# What of the following commands could accomplish this?
schools<-c("U. Kentucky", "Univ New Hampshire", "Univ. of Massachusetts", "University Georgia", "U California", "California State University")
# option1
schools %>%  # No
  str_replace("Univ\\.?|U\\.?", "University ") %>% 
  str_replace("^University of |^University ", "University of ")
# option2 
schools %>% # Yes
  str_replace("^Univ\\.?\\s|^U\\.?\\s", "University ") %>% 
  str_replace("^University of |^University ", "University of ")
# option3 # No
  schools %>% 
  str_replace("^Univ\\.\\s|^U\\.\\s", "University") %>% 
  str_replace("^University of |^University ", "University of ")
# option4 # No
schools %>% 
  str_replace("^Univ\\.?\\s|^U\\.?\\s", "University") %>% 
  str_replace("University ", "University of ")

# Answer:option2

#.................................Question 10................................

# Rather than using the pattern_with_groups vector from the video, 
# you accidentally write in the following code:
problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")

# Answer:option1: "5'3"   "5'5"   "6 1"   "5 .11" "5, 12"

#.................................Question 11................................

# You notice your mistake and correct your pattern regex to the following
problems <- c("5.3", "5,5", "6 1", "5 .11", "5, 12")
pattern_with_groups <- "^([4-7])[,\\.\\s](\\d*)$"
str_replace(problems, pattern_with_groups, "\\1'\\2")

# What is your result?

# Answer:option3:"5'3"   "5'5"   "6'1"   "5 .11" "5, 12"

#.................................Question 12................................

# In our example, we use the following code to detect height entries that 
# do not match our pattern of x'y":
converted <- problems %>% 
  str_replace("feet|foot|ft", "'") %>% 
  str_replace("inches|in|''|\"", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
index <- str_detect(converted, pattern)
converted[!index]
# Which answer best describes the differences between the regex string 
# we use as an argument in str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") # and the 
# regex string in pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"?

# Answer:option4:
# The regex used in str_replace() looks for either a comma, period or space 
# between the feet and inches digits, while the pattern regex just looks for 
# an apostrophe; the regex in str_replace allows for none or more digits to 
# be entered as inches, while the pattern regex only allows for one or two digits.

#.................................Question 13................................

# You notice a few entries that are not being properly converted using your 
# str_replace() and str_detect() code:
yes <- c("5 feet 7inches", "5 7")
no <- c("5ft 9 inches", "5 ft 9 inches")
s <- c(yes, no)

converted <- s %>% 
  str_replace("feet|foot|ft", "'") %>% 
  str_replace("inches|in|''|\"", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)
# [1]  TRUE TRUE FALSE FALSE

# It seems like the problem may be due to spaces around the words feet|foot|ft 
# and inches|in. What is another way you could fix this problem?
# Answer:option1:
converted <- s %>% 
  str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
  str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

converted_1<- s %>% 
  str_replace("\\s*(feet|foot|ft)\\s*", "'") %>% 
  str_replace("\\s*(inches|in|''|\")\\s*", "") %>% 
  str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")
pattern <- "^[4-7]\\s*'\\s*\\d{1,2}$"
str_detect(converted, pattern)

converted_2 <- s %>% 
  str_replace("\\s+feet|foot|ft\\s+", "'") %>% 
    str_replace("\\s+inches|in|''|\"\\s+", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")

  converted_3 <- s %>% 
    str_replace("\\s*|feet|foot|ft", "'") %>% 
    str_replace("\\s*|inches|in|''|\"", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2") 
    
   converted <- s %>% 
    str_replace_all("\\s", "") %>% 
    str_replace("\\s|feet|foot|ft", "'") %>% 
    str_replace("\\s|inches|in|''|\"", "") %>% 
    str_replace("^([4-7])\\s*[,\\.\\s+]\\s*(\\d*)$", "\\1'\\2")    
        