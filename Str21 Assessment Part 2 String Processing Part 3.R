# Str 16 Assessment Part 2: String Processing Part 3

# Import raw Brexit referendum polling data from Wikipedia:

library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[6]] %>% html_table(fill = TRUE)

head(polls)
view(polls)
str(polls)
polls<-as.tibble(polls)

# ......................Question 4........................


# Some rows in this table do not contain polls. 
# You can identify these by the lack of the percent sign (%) in the Remain column.

# Update polls by changing the column names to c("dates", "remain", "leave", 
 # "undecided", "lead", "samplesize", "pollster", "poll_type", "notes") and 
# only keeping rows that have a percent sign (%) in the remain column.

# How many rows remain in the polls data frame?


pattern <- "%"
str_detect(polls$Remain, pattern) 
sum(str_detect(polls$Remain, pattern) )

polls_new <- polls %>% 
  filter(str_detect(polls$Remain, pattern))
nrow(polls_new)

# Answer:129

# ......................Question 5........................

# The remain and leave columns are both given in the format "48.1%": percentages
 # out of 100% with a percent symbol.
# Which of these commands converts the remain vector to a proportion between 
# 0 and 1? Check all correct answers.

# Choise-1
as.numeric(str_remove(polls_new$Remain, "%")) # Not Answer

# Choise-2
as.numeric(polls_new$Remain)/100 # Not Answer

# Choise-3
parse_number(polls_new$Remain)   # Not Answer

# Choise-4
str_remove(polls_new$Remain, "%")/100 # Error message

# Choise-5
as.numeric(str_replace(polls_new$Remain, "%", ""))/100 # Answer

# Choise-6
parse_number(polls_new$Remain)/100 # Answer

# Answer:Choise-5 & Choise-6

# ......................Question 6........................

# The undecided column has some "N/A" values. These "N/A"s are only present 
# when the remain and leave columns total 100%, so they should actually be zeros.
# Use a function from stringr to convert "N/A" in the undecided column to 0. 
# The format of your command should be 
function_name(polls$undecided, "arg1", "arg2").
# What function replaces function_name?
str_replace(polls$Undecided,"N/A","0")

# What function replaces function_name?     Answer: str_replace
# What argument replaces arg1               Answer:N/A
# What argument replaces arg2               Answer: 0

# ......................Question 7........................

# The dates column contains the range of dates over which the poll was conducted. 
# The format is "8-10 Jan" where the poll had a start date of 2016-01-08 and end
# date of 2016-01-10. Some polls go across month boundaries (16 May-12 June).

# The end date of the poll will always be one or two digits, followed by a space,
# followed by the month as one or more letters (either capital or lowercase). 
# In these data, all month abbreviations or names have 3, 4 or 5 letters.

# Write a regular expression to extract the end day and month from dates.
# Insert it into the skeleton code below:
temp <- str_extract_all(polls$dates, _____)
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)


# Which of the following regular expressions correctly extracts the end day and
# month when inserted into the blank in the code above?

names(polls)
# Choise-1

"\\d?\\s[a-zA-Z]?"      # All values have errors

P1<-"\\d?\\s[a-zA-Z]?"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P1))
view(polls)

# Choise-2

"\\d+\\s[a-zA-Z]+"     # Answer

P2<-"\\d+\\s[a-zA-Z]+"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P2))
view(polls)

# Choise-3

"\\d+\\s[A-Z]+"       # All values have errors

P3<-"\\d+\\s[A-Z]+"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P3))
view(polls)


# Choise-4

"[0-9]+\\s[a-zA-Z]+"      # Answer

P4<-"[0-9]+\\s[a-zA-Z]+"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P4))
view(polls)

# Choise-5

"\\d{1,2}\\s[a-zA-Z]+"         # Answer

P5<-"\\d{1,2}\\s[a-zA-Z]+"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P5))
view(polls)


# Choise-6

"\\d{1,2}[a-zA-Z]+"    # All values have errors

P6<-"\\d{1,2}[a-zA-Z]+"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P6))
view(polls)

# Choise-7

"\\d+\\s[a-zA-Z]{3,5}"     # Answer

P7<-"\\d+\\s[a-zA-Z]{3,5}"
polls<-polls%>%
  mutate(end_date=str_extract_all(polls$"Date(s) conducted", P7))
view(polls)

# Answer : Choise-2, 4, 5 & 7