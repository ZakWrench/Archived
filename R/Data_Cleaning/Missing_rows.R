#Missing rows

land <- read_csv("publiclands.csv")

summary(land)

#Check number of rows
nrow(land)

#Name of all unique rows
unique(land$State)

missing_states <- tibble(State=c('Connecticut', 'Delaware', 'Hawaii', 'Iowa', 'Maryland', 'Massachusetts', 'New Jersey', 'Rhode Island'), PublicLandAcres=c(0,0,0,0,0,0,0,0))

land <- rbind(land, missing_states)
