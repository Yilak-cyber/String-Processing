# Str16 String Splitting

#Textbook link

# This video corresponds to the 
# https://rafalab.github.io/dsbook/string-processing.html#string-splitting

# Key Points

# The function str_split() splits a string into a character vector on a delimiter
# (such as a comma, space or underscore). By default, str_split() generates a 
# list with one element for each original string. Use the function argument 
# simplify=TRUE to have str_split() return a matrix instead.

# The map() function from the purrr package applies the same function to each 
# element of a list. To extract the ith entry of each element x, use map(x, i).
# map() always returns a list. Use map_chr() to return a character vector
 # and map_int() to return an integer.
# read raw murders data line by line
filename <- system.file("extdata/murders.csv", package = "dslabs")
lines <- readLines(filename)
lines %>% head()

# split at commas with str_split function, remove row of column names
x <- str_split(lines, ",") 
x %>% head()
col_names <- x[[1]]
x <- x[-1]

# extract first element of each list entry
library(purrr)
map(x, function(y) y[1]) %>% head()
map(x, 1) %>% head()

map(x, 2) %>% head()
map(x, 3) %>% head()
map(x, 4) %>% head()
# extract columns 1-5 as characters, then convert to proper format - NOTE: DIFFERENT FROM VIDEO
dat_1 <- data.frame(parse_guess(map_chr(x, 1)),
                  parse_guess(map_chr(x, 2)),
                  parse_guess(map_chr(x, 3)),
                  parse_guess(map_chr(x, 4)),
                  parse_guess(map_chr(x, 5))) %>%
  setNames(col_names)

dat_1 %>% head

# more efficient code for the same thing
dat_2 <- x %>%
  transpose() %>%
  map( ~ parse_guess(unlist(.))) %>%
  setNames(col_names) %>% 
  as.data.frame() 
dat_2 %>% head
identical(dat_1,dat_2)
# the simplify argument makes str_split return a matrix instead of a list
x_a <- str_split(lines, ",", simplify = TRUE) 
x_a
col_names <- x[1,]
x_b<- x[-1,]
x_b %>% as_data_frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)
ourdata<-x_b%>% as_data_frame() %>%
  setNames(col_names) %>%
  mutate_all(parse_guess)

ourdata
ourdata$state[37]




