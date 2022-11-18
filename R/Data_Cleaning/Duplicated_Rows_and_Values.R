#Duplicate rows and values

continents <- read_csv("continents.csv")

View(continents)

#Remove identical duplicated rows
continents <- unique(continents)

#By applying some common sense, we deduce that there's 4490 peoples in Antartica and not 4490000

continents <- continents %>% filter(!(Continent=='Antarctica' & Population>100000))


