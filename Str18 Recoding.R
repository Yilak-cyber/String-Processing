# Key points
# Change long factor names with the recode() function from the tidyverse. 
# Other similar functions include recode_factor() and fct_recoder() in the 
# forcats package in the tidyverse. The same result could be obtained using the 
# case_when() function, but recode() is more efficient to write.
# life expectancy time series for Caribbean countries
library(dslabs)
library(tidyverse)
data("gapminder")
gapminder
str(gapminder)
gapminder %>% 
  filter(region=="Caribbean") %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()

gapminder$country

# display long country names
gapminder %>% 
  filter(region=="Caribbean") %>%
  filter(str_length(country) >= 12) %>%
  distinct(country) 


# recode long country names and remake plot
gapminder %>% filter(region=="Caribbean") %>%
  mutate(country = recode(country, 
                          'Antigua and Barbuda'="Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad")) %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()


gapminder<-gapminder %>% filter(region=="Caribbean") %>%
  mutate(country = recode(country, 
                          'Antigua and Barbuda'="Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad")) %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()


gapminder<-gapminder %>% filter(region=="Caribbean") %>%
  mutate(country = recode(country, 
                          'Antigua and Barbuda'="Barbuda",
                          'Dominican Republic' = "DR",
                          'St. Vincent and the Grenadines' = "St. Vincent",
                          'Trinidad and Tobago' = "Trinidad"))


gapminder_feb13<-gapminder %>% filter(region=="Caribbean") %>%
  mutate(country2 = recode(country, 
                           'Antigua and Barbuda'="Barbuda",
                           'Dominican Republic' = "DR",
                           'St. Vincent and the Grenadines' = "St. Vincent",
                           'Trinidad and Tobago' = "Trinidad"))
gapminder_feb13%>%select(country,country2)
  

gapminder_feb13%>%
  filter(str_length(country) >= 12)

