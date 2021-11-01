#################################
# Case Study 1: US Murders Data #
#################################

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Key points
#...............................

# Use the str_detect() function to determine whether a string contains 
# a certain pattern.
# Use the str_replace_all() function to replace all instances of one pattern
# with another pattern. To remove a pattern, replace with the empty string ("").
# The parse_number() function removes punctuation from strings and converts 
# them to numeric.
# mutate_at() performs the same transformation on the specified column numbers.
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# murders_raw was defined in the web scraping section

# str_detect can help us detect any pattern

# detect comma
y<-"256,438"
str_detect(y, ",")
# detect @
z<-"example@gmail.com"
str_detect(z, "@")

#Replacing strings
str_replace_all(z,"@","")

# detect whether there are commas
commas <- function(x) any(str_detect(x, ","))
murders_raw %>% summarize_all(funs(commas))

# replace commas with the empty string and convert to numeric
test_1 <- str_replace_all(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)
test_1
class(test_1)

# we can remove the commas by str_replace_all or using  parse_number functions
# parse_number also removes commas and converts to numeric
test_2 <- parse_number(murders_raw$population)
identical(test_1, test_2)

head(murders_raw)
murders_new <- murders_raw %>% mutate_at(2:3, parse_number)
head(murders_new)
class(murders_new$population)
murders_new %>% head