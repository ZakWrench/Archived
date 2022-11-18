install.packages("foreign")
install.packages("ggplot2")
install.packages("MASS")
install.packages("Hmisc")
install.packages("reshape2")

library(foreign)
library(ggplot2)
library(MASS)
library(Hmisc)
library(reshape2)


dat <- read.dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")
head(dat)

lapply(dat[,c("apply","pared","public")],table)
ftable(xtabs(~ public + apply + pared, data = dat))
summary(dat$gpa)
sd(dat$gpa)
sd(dat$gpa, na.rm = FALSE)

ggplot(dat, aes(x = apply, y = gpa) + geom_boxplot(size = .75) + geom_jitter(alpha = .5) + facet_grid(pared ~ public margins = TRUE) + theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) )
ggplot(dat, aes(x = apply, y = gpa)) +
  geom_boxplot(size = .75) +
  geom_jitter(alpha = .5) +
  facet_grid(pared ~ public, margins = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

m <- polr(apply ~ pared + public + gpa , data =dat, Hess = TRUE)

summary(m)


##store table 
(ctable <- coef(summary(m)))

p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) *2
(ctable <- cbind(ctable, "pvalue" = p))

(ci <- confint(m))

exp(coef(m))

exp(cbind(OR = coef(m), ci))


sf <- function(y) {
  c('Y>=1' = qlogis(mean(y >= 1)), 
    'Y>=2' = qlogis(mean(y >= 2)),
    'Y>=3' = qlogis(mean(y >= 3)))
}


sf <- function(y) {
  c('Y>=1' = qlogis(mean(y >= 1)),
    'Y>=2' = qlogis(mean(y >= 2)),
    'Y>=3' = qlogis(mean(y >= 3)))
}


(s <- with(dat, summary(as.numeric(apply) ~ pared + public + gpa, fun=sf)))
glm(I(as.numeric(apply) >= 2)~ pared , family="binomial", data = dat)

glm(I(as.numeric(apply) >=3) ~ pared, family = "binomial", data= dat)

x <- c(2, 5, 5, 8)
y <- c(22, 28, 32, 35, 40, 41)

#attempt to create scatterplot of x vs. y
plot(x, y)

length(x)
length(y)





s[, 4] <- s[, 4] - s[, 3]
s[, 3] <- s[, 3] - s[, 3]

length(s[, 3]) == length(s[, 4])


par(mar = c(1, 1, 1, 1))
plot(s, which= 1:3, pch= 1:3, xlab = 'logit', main= '', xlim= range(s[,3:4]))

newdat <- data.frame(
  pared = rep(0:1, 200),
  public = rep(0:1, each = 200),
  gpa = rep(seq(from = 1.9, to = 4, length.out= 100),4))


newdat <- cbind(newdat, predict(m, newdat, type= "probs"))

head(newdat)


lnewdat <- melt(newdat, id.vars = c("pared","public", "gpa"),
                variable.name = "Level", value.name= "x")

head(lnewdat)

ggplot(lnewdat, aes(x = gpa, y = x, colour = Level))+
  geom_line() + facet_grid(pared~ public, labeller = "label_both")

