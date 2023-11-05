rm(list=ls()) # removes all variables stored previously
   library(Hmisc) #import

data <- read.csv("~/COVID19_line_list_data.csv")
describe (data) #Hmisc command

# cleaned up death column
data$death_dummy <- as.integer(data$death != 0) 
#death rate
sum(data$death_dummy)/nrow(data)

# Age
#claim: individuals who die are older than individuals that are younger
dead= subset(data, death_dummy == 1)
alive= subset(data, death_dummy ==0)
mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)
# Is it statistically significant?
t.test(alive$age, dead$age, alternative="two.sided", conf.level = 0.95)
#normally in statistics, if p-value <0.05, we reject null hypothesis
# p-value is 0, reject H0
#statistically significant 

# Gender
#claim: gender has no effect
men= subset(data, gender == "male")
women= subset(data, gender =="female")
mean(men$death_dummy, na.rm = TRUE) #8.4%
mean(women$death_dummy, na.rm = TRUE) #3.7%
# Is it statistically significant?
t.test(men$death_dummy, women$death_dummy, alternative="two.sided", conf.level = 0.95)
#95% confidence: men have from 0.8% to 8.8% higher chance of dying (than women)
# p-value = 0.002 < 0.05, statistically significant
#significant



