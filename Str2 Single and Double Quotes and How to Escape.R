##############################################
# Single and Double Quotes and How to Escape #
##############################################

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Key points
...............................
# Define a string by surrounding text with either single quotes or double quotes.
# To include a single quote inside a string, use double quotes on the outside. 
# To include a double quote inside a string, use single quotes on the outside.
# The cat() function displays a string as it is represented inside R.
# To include a double quote inside of a string surrounded by double quotes, 
# use the backslash (\) to escape the double quote. 
# Escape a single quote to include it inside of a string defined by single quotes.
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# We will see additional uses of the escape later.
s1 <- "Hello!"    # double quotes define a string
s1
s2 <- 'Hello!'    # single quotes define a string
s2
s3 <- `Hello`    # backquotes does not work
s4 <- Hello   # without quotes does not work

5'
'10"'
s5 <- "10""    # error - unclosed quotes

s6 <- '10"'    # correct

# cat shows what the string actually looks like inside R
cat(s6)

s7 <- "5'"
cat(s7)

5'10"
# to include both single and double quotes in string, escape with \

s8 <- '5'10"'    # error
s9 <- "5'10""    # error
s_10 <- '5\'10"'    # correct
cat(s_10)
s_11 <- "5'10\""    # correct
cat(s_11)
#  Challenge: How can use inside a string use '' or ""

s_12 <-"use '' or \"\""
cat(s_12)