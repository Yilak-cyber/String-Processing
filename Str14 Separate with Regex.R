#######################
# Separate with Regex #
#######################
# The extract() function behaves similarly to the separate() function 
# but allows extraction of groups from regular expressions.
library(tidyverse)
library(dslabs)
library(stringr)
library(dslabs)
data(reported_heights)
# In the previous videos, we constructed regex that lets us identify which 
 # elements of a character vector match the feet and inches pattern.
# However, we want to do more. We want to extract and save the feet and number 
 # value so that we can convert them to inches when appropriate.
# We're going to construct a simpler case. So we're going to make it like this.

# first example - normally formatted heights
s <- c("5'10", "6'1")
tab <- data.frame(x = s)
head(tab)
# We have already learned to use the separate functions.
# So we can use this code to separate out the feet part and the inches part.

# the separate and extract functions behave similarly

tab %>% separate(x, c("feet", "inches"), sep = "'")

# The extract function from the tidyr package lets us use regex groups 
#to extract the desired values.
# Here's the equivalent code using extract to the code using separate.


tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
# So why do we even need the new function extract?
# The reason is that groups in regex give us much more flexibility.

# For example, if we define an example like this and we only want the numbers,
# separate fails.
tab %>% separate(x, c("feet","inches"), sep = "'", fill = "right")

#Look at what happens. 

s <- c("5'10", "6'1\"","5'8inches")
tab <- data.frame(x = s)
head(tab)

# separate fails because it leaves in extra characters, but extract keeps only 
# the digits because of regex groups
# But we can use extract.
# The regex here is a bit more complicated, as we have to permit the single 
 #quote with spaces in feet.
# But we also do want the double quotes included in the value, so we do not
 # include that in the group.
# So we can use extract to obtain the numbers that we want using this code.

tab %>% extract(x, c("feet", "inches"), regex = "(\\d)'(\\d{1,2})")
# We can use separate and extract in our case study, and in the class material
# we have the code that finishes off the problems and extracts the height in
# inches for the great majority of students.

#<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>
# We'll let you study that on your own.#
#<<<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>>>>

###########################
# Putting it all together #
###########################

