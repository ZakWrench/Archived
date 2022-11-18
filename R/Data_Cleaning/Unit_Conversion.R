weather <-read_csv("mexicanweather.csv")

#Let's make this dataset a little wider to get the minimum and maximum temperatures as part of the same observation.
#That requires the spread function
weather <- weather %>% spread(element, value)

#That's the right format, but take a look at the data, it's pretty sparse.
#We really don't need all of those lines that have two NA values

weather <- weather %>% filter(!(is.na(TMAX) & is.na(TMIN)))

#Let's make those column names nicer, and just for tidyness, let's put the min before the max
weather <- weather %>% rename(maxtemp=TMAX, mintemp=TMIN) %>% select(station, date, mintemp, maxtemp)

head(weather, n=20)

weather <- weather %>%
  mutate(mintemp=mintemp/10) %>%
  mutate(maxtemp=maxtemp/10)
head(weather)

#convert cel to farh
weather <- weather %>%
  mutate(mintemp=mintemp*(9/5)+32) %>%
  mutate(maxtemp=maxtemp*(9/5)+32)
