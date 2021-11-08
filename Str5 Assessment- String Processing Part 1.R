library(tidyverse)
library(stringr)
# Assessment: String Processing Part 1

# ......................Question 1........................

# Which of the following is NOT an application of string parsing?
# Answer : Formatting numbers and characters so they can easily be displayed in
   # deliverables like papers and presentations.

# Note:Formatting text and numbers for deliverables is not an application of 
# string parsing. String parsing is used as part of the data wrangling process.

# ......................Question 2........................

# Which of the following commands would not give you an error in R?
cat(" LeBron James is 6'8\" ")
cat(' LeBron James is 6'8" ')
cat(` LeBron James is 6'8" `)
cat(" LeBron James is 6\'8" ")
# Answer: cat(" LeBron James is 6'8\" ")

# Note: This would correctly print out your string. Because the string is 
      # enclosed in double quotes, (""), you must use an escape character before 
      # the inches symbol (").

# ......................Question 3........................  
  
# Which of the following are advantages of the stringr package over string 
# processing functions in base R? Select all that apply.

# Answer:
# Functions in stringr all start with "str_", which makes them easy to look up
       # using autocomplete.
# Stringr functions work better with pipes.
# The order of arguments is more consistent in stringr functions than in base R.

# ......................Question 3........................  

# You have a data frame of monthly sales and profits in R:
  
# head(dat)
# A tibble: 5 x 3
# Month     Sales     Profit 
# <chr>     <chr>     <chr>  
# January   $128,568  $16,234
# February  $109,523  $12,876
# March     $115,468  $17,920
# April     $122,274  $15,825
# May       $117,921  $15,437

# Which of the following commands could convert the sales and profits columns 
      # to numeric? Select all that apply.
# Answer:  
# dat %>% mutate_at(2:3, parse_number)
# dat %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% 
     # mutate_at(2:3, as.numeric)

#You can use the parse_number command to remove all non-numeric characters.
# Combining this with the mutate_at command allows you to reformat column two 
# and  three (Sales and Profit).
# You can use the str_replace_all command to replace both the "$" and "," 
# characters, by specifying these in the "pattern" argument of the command. 
# Combining this function with the mutate_at command allows you to reformat 
# both column two and three (Sales and Profit). You then need to use the 
# "as.numeric" command to convert these columns from character strings to numbers.




########################################
# Assessment: String Processing Part 1 #
########################################


# ..........................Quesuion 1 ..........................

# Which of the following is NOT an application of string parsing?

# Answer: Formatting numbers and characters so they can easily be displayed 
# in deliverables like papers and presentations.

# Formatting text and numbers for deliverables is not an application 
# of string parsing. String parsing is used as part of the data wrangling process.

# ..........................Quesuion 2 ..........................

# Which of the following commands would not give you an error in R?
cat(" LeBron James is 6'8\" ")
cat(' LeBron James is 6'8" ')
cat(` LeBron James is 6'8" `)
cat(" LeBron James is 6\'8" ")

# Answer: cat(" LeBron James is 6'8\" ")
# This would correctly print out your string. Because the string is 
 # enclosed in double quotes, (""), you must use an escape character 
 # before the inches symbol (").

# ..........................Quesuion 3 ..........................

# Which of the following are advantages of the stringr package over 
  # string processing functions in base R? Select all that apply.

# Answer:Functions in stringr all start with "str_", which makes them 
  # easy to look up using autocomplete.
# Stringr functions work better with pipes.
# The order of arguments is more consistent in stringr functions than in base R.

# ..........................Quesuion 4 ..........................
# You have a data frame of monthly sales and profits in R:
> head(dat)
# A tibble: 5 x 3
Month     Sales     Profit 
<chr>     <chr>     <chr>  
January   $128,568  $16,234
February  $109,523  $12,876
March     $115,468  $17,920
April     $122,274  $15,825
May       $117,921  $15,437

Month<-c('January','February','March','April', 'May')
Sales<-c('$128,568','$109,523','$115,468','$122,274','$117,921')
Profit<-c('$16,234','$12,876','$17,920', '$15,825', '$15,437')
dat<-data.frame(Month=Month,Sales=Sales,Profit=Profit)
dat

as_tibble(dat)

# Which of the following commands could convert the sales and profits 
 # columns to numeric? Select all that apply.
dat %>% mutate_at(2:3, parse_number)
dat %>% mutate_at(2:3, as.numeric)
dat %>% mutate_all(parse_number)
dat %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% 
  mutate_at(2:3, as.numeric)

# Answer: dat %>% mutate_at(2:3, parse_number)
          # dat %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% 
  #  mutate_at(2:3, as.numeric)

dat %>% mutate_at(2:3, parse_number)
dat %>% mutate_at(2:3, as.numeric)
dat %>% mutate_all(parse_number)
dat %>% mutate_at(2:3, funs(str_replace_all(., c("\\$|,"), ""))) %>% 
    mutate_at(2:3, as.numeric)