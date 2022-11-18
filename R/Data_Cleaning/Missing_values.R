
heating <- read_csv("heating.csv")

#Tidy the data
heating_tidy <- heating %>% gather(key="age", value="homes", -Source)

summary(heating)
summary(heating_tidy)

heating_tidy %>% mutate(homes=as.numeric(homes))

#filter select rows that meet certain criteria, our case is NA values
heating_tidy %>% filter(is.na(as.numeric(homes)))

#after seeing what the Z value means, it means values rounded to zero after division operation
#and Period represent value that are truly zero.

heating_tidy %>%
  mutate(homes=ifelse(homes==".",0,homes)) %>%
  mutate(homes=ifelse(homes=="Z",0,homes)) %>%
  mutate(homes=as.numeric(homes)) %>%
  filter(Source == "Cooking stove")

#Creating pipeline
heating_final <-heating_tidy %>%
  mutate(homes=ifelse(homes==".",0,homes)) %>%
  mutate(homes=ifelse(homes=="Z",0,homes)) %>%
  mutate(homes=as.numeric(homes))

summary(heating_final)

write.csv(heating_final,"heating_final.csv", row.names = FALSE)
