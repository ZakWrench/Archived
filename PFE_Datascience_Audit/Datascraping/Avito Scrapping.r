library(rvest)
library(dplyr)

setwd("C:\\Users\\Fatihi\\Desktop\\Lab\\datamine_avito")
path <- "C:\\Users\\Fatihi\\Desktop\\Lab\\datamine_avito"

link = "https://www.avito.ma/fr/rabat/appartements-%C3%A0_louer"
page = read_html(link)

avito = data.frame()

for( page_result in seq(from = 1, to = 2, by = 1)){
  link = paste0("https://www.avito.ma/fr/khouribga/appartements-%C3%A0_louer?spr=500","&o=",page_result)
  page = read_html(link)
  prix = page %>% html_nodes(".caZekr span:nth-child(1)") %>% html_text()
  dh = page %>% html_nodes(".caZekr span+ span") %>% html_text()
  avito = rbind(avito,data.frame(prix,dh, stringAsFactors = FALSE))
  print(paste("page", page_result ))
}



write.csv(avito, file.path(path, "Khouribga.csv"), row.names=FALSE)
