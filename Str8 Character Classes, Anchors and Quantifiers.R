################################################
# Character Classes, Anchors and Quantifiers   #
################################################

#........................Key points.............................................

# Define strings to test your regular expressions, including some elements 
# that match and some that do not. This allows you to check for the two types
# of errors: failing to match and matching incorrectly.
# Square brackets define character classes: groups of characters that count as
# matching the pattern. You can use ranges to define character classes, such as
# [0-9] for digits and [a-zA-Z] for all letters.
# Anchors define patterns that must start or end at specific places. 
# ^ and $ represent the beginning and end of the string respectively.
# Curly braces are quantifiers that state how many times a certain character 
# can be repeated in the pattern. \\d{1,2} matches exactly 1 or 2 consecutive
#digits.
#...............................................................................

# s was defined in the previous video
yes <- c("5", "6", "5'10", "5 feet", "4'11")
no <- c("", ".", "Five", "six")
s <- c(yes, no)
pattern <- "\\d"

# [56] means 5 or 6
str_view(s, "[56]") 
str_detect(s, "[56]")

# [4-7] means 4, 5, 6 or 7
a<-4:7
a
as.character(a)

yes <- as.character(4:7)
no <- as.character(1:3)
s <- c(yes, no)
str_detect(s, "[4-7]")

# ^ means start of string, $ means end of string
pattern <- "^\\d$"
yes <- c("1", "5", "9")
no <- c("12", "123", " 1", "a4", "b")
s <- c(yes, no)
str_view(s, pattern)
str_detect(s, pattern)
# curly braces define quantifiers: 1 or 2 digits 
pattern <- "^\\d{1,2}$"
yes <- c("1", "5", "9", "12")
no <- c("123", "a4", "b")
str_view(c(yes, no), pattern)
str_view_all(c(yes, no), pattern)
str_detect(c(yes, no), pattern)
# combining character class, anchors and quantifier
pattern <- "^[4-7]'\\d{1,2}\"$"
cat(pattern)
yes <- c("5'7\"", "6'2\"",  "5'12\"")
cat(yes)
no <- c("6,2\"", "6.2\"","I am 5'11\"", "3'2\"", "64")
cat(no)
str_detect(yes, pattern)
str_detect(no, pattern)


##Here I stopped on 11/1/2021