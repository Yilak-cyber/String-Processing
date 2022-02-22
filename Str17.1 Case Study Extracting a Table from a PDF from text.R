
# One of the datasets provided in dslabs shows scientific funding rates by 
 # gender in the Netherlands:
library(tidyverse)
library(dslabs)
data("research_funding_rates")
research_funding_rates %>% 
  select("discipline", "success_rates_men", "success_rates_women")

# The data comes from a paper published in the Proceedings of the National 
 # Academy of Science (PNAS)92, a widely read scientific journal. However, the 
 # data is not provided in a spreadsheet; it is in a table in a PDF document. 
# Here is a screenshot of the table:

# (Source: Romy van der Lee and Naomi Ellemers, PNAS 2015 112 (40) 12349-1235393.)

# We could extract the numbers by hand, but this could lead to human error. 
# Instead, we can try to wrangle the data using R. We start by downloading 
 # the pdf document, then importing into R:

library("pdftools")
temp_file <- tempfile()
url <- paste0("https://www.pnas.org/content/suppl/2015/09/16/",
              "1510159112.DCSupplemental/pnas.201510159SI.pdf")
download.file(url, temp_file)
txt <- pdf_text(temp_file)
file.remove(temp_file)

#If we examine the object text, we notice that it is a character vector with an 
 # entry for each page. So we keep the page we want:

raw_data_research_funding_rates <- txt[2]


#The steps above can actually be skipped because we include this raw data in 
 # the dslabs package as well:

data("raw_data_research_funding_rates")

#Examining the object raw_data_research_funding_rates we see that it is a long 
 #string and each line on the page, including the table rows, are separated by 
 # the symbol for newline: \n. We therefore can create a list with the lines 
 #of the text as elements as follows:

tab <- str_split(raw_data_research_funding_rates, "\n")

#Because we start off with just one element in the string, we end up with a 
 # list with just one entry.

tab <- tab[[1]]

#By examining tab we see that the information for the column names is the third 
 # and fourth entries:

the_names_1 <- tab[3]
the_names_2 <- tab[4]

#The first of these rows looks like this:

the_names_1 <- the_names_1 %>%
  str_trim() %>%
  str_replace_all(",\\s.", "") %>%
  str_split("\\s{2,}", simplify = TRUE)
the_names_1 

#We want to create one vector with one name for each column. Using some of the 
 #functions we have just learned, we do this. Let's start with the_names_1, 
 #shown above. We want to remove the leading space and anything following 
 #the comma. We use regex for the latter. Then we can obtain the elements by 
 #splitting strings separated by space. We want to split only when there are 2 
 # or more spaces to avoid splitting Success rates. So we use the regex \\s{2,}

#Now we will look at the_names_2:
# Here we want to trim the leading space and then split by space as we did for 
 # the first line:

the_names_2 <- the_names_2 %>%
  str_trim() %>%
  str_split("\\s+", simplify = TRUE)
the_names_2
#We can then join these to generate one name for each column:

tmp_names <- str_c(rep(the_names_1, each = 3), the_names_2[-1], sep = "_")
the_names <- c(the_names_2[1], tmp_names) %>%
  str_to_lower() %>%
  str_replace_all("\\s", "_")
the_names

#Now we are ready to get the actual data. By examining the tab object, we notice
 # that the information is in lines 6 through 14. We can use str_split again to 
 #achieve our goal:

new_research_funding_rates <- tab[6:14] %>%
  str_trim %>%
  str_split("\\s{2,}", simplify = TRUE) %>%
  data.frame() %>%
  setNames(the_names) %>%
  mutate_at(-1, parse_number)
new_research_funding_rates %>% as_tibble()

#We can see that the objects are identical:

identical(research_funding_rates, new_research_funding_rates)
