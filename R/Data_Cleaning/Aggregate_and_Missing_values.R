#Aggregation and Missing values

employees <- read_csv("employees.csv")

View(employees)

#Sum of salaries
sum(employees$Salary)
#Mean
mean(employees$Salary)
#Max
max(employees$Salary)

#ignore NA values
sum(employees$Salary,na.rm=TRUE)
mean(employees$Salary,na.rm=TRUE)
max(employees$Salary, na.rm=TRUE)





