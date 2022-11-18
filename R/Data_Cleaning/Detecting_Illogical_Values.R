#Detecting Illogical Values

residents <- read_csv("residents.csv")
View(residents)

summary(residents)

residents <- read_csv("residents.csv", col_types = "iillll")

residents %>%
  filter(ownsHome==rentsHome)
