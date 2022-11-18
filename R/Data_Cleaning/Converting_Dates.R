weather <-read_csv("mexicanweather.csv")

weather

weather$year <- year(weather$date)
weather$month <-month(weather$date)
weather$day <-day(weather$date)

#allow you to determine the day of the week for a particular date
wday("2018-04-01")

#allow you to determine the day of the year for a particular date
yday("2018-04-01")

#Building dates according to the american date system
mdy("04/01/2018") # you can also put 18 to imply 2018

#building dates according to the European date system, converted auto
dmy("04/01/18")

