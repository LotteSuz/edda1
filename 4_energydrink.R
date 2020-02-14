data <- data.frame(read.csv("run.txt", sep="")
par(mfrow=c(1,1))

plot(data$before, data$after, xlab="Before", ylab="After", main="Runningtime for all pupils")

ggplot(data, aes(x=data$before, y=data$after)) + geom_point()

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
t.test(lemo_dif,energy_dif,paired=FALSE)
