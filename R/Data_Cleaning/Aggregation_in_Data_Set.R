#Aggregations in the data set

carpinteria <- read_csv("population.csv")

View(carpinteria)

glimpse(carpinteria)

#summing give erroneous results because there's already a row with total population, given it's a census 
#hence applying addition three times, once for the total, once with the gender, and once with the age
sum(carpinteria$Population)

carpinteria <- carpinteria %>% filter(!(Subject %in% c('Total', 'Male', 'Female')))

View(carpinteria)

sum(carpinteria$Population)
