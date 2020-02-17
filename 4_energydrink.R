data <- data.frame(read.csv("run.txt", sep=""))
par(mfrow=c(1,1))

plot(data$before, data$after, xlab="Before", ylab="After", main="Runningtime for all pupils")

ggplot(data, aes(x=data$before, y=data$after)) + geom_point(shape=18, color="black") +
  geom_smooth(method=lm,  linetype="dashed",
              color="darkred", fill="blue") +
  labs(x = "Run before", y= "Run after", title = "Runningtime for all pupils")

# First check for normality
shapiro.test(data$before) # p-value > 0.05, so normally distributeed
shapiro.test(data$after)
result = cor.test(data$before,data$after)
print(result)
print(result$p.value)

# Sort by group lemo and energy
lemo = data[1:12,]
energy = data[13:24,]
t.test(lemo$before,lemo$after,paired=TRUE)
t.test(energy$before,energy$after,paired=TRUE)

# Compute difference between times
difference = data$before - data$after
shapiro.test(difference) # Check for normality
lemo_dif = difference[1:12]
energy_dif = difference[13:24]

data1 = data[1:12,1:2]
data2 = data[13:24,1:2]
ggplot(data1, aes(x=data1$before, y=data1$after)) + geom_point(shape=18, color="black") +
  geom_smooth(method=lm,  linetype="dashed",
              color="darkred", fill="blue") +
  labs(x = "Run before", y= "Run after", title = "Runningtimes for lemo drink")

boxplot(data1)
boxplot(data2)

dat <- data.frame(Condition = factor(rep(c(".Before","After"), each=12)), Runningtime = c(data1$before,data1$after))

ggplot(dat, aes(x=Condition, y=Runningtime)) +  geom_boxplot() +
  labs(title = "Runningtimes") + theme_grey(base_size = 21)

t.test(lemo_dif,energy_dif,paired=FALSE)
