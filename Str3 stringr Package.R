###################
# stringr Package #
###################
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Key points
#...............................
# The main types of string processing tasks are detecting, locating, 
# extracting and replacing elements of strings.
# The stringr package from the tidyverse includes a variety of string 
# processing functions that begin with str_ and take the string as the 
# first argument, which makes them compatible with the pipe.
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# murders_raw defined in web scraping video

# direct conversion to numeric fails because of commas
d1<-murders_raw$total
head(murders_raw)
pattern<-","
str_detect(d1, pattern)

str_detect(y, ",")
murders_raw$population[1:3]
as.numeric(murders_raw$population[1:3]) # as.numeric doesn't work
a<-"5"
a
b<-"2,500"
b
c<-as.numeric(b)
c
as.numeric(a)
library(tidyverse)    # includes stringr