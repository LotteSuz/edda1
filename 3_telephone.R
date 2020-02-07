telephone <- read.csv("~/Documents/master/Experimental/edda1/data/telephone.txt", sep="")
data = telephone$Bills
hist(data)

data <- data[which(data <= 60)]

# Calculate mean
median.result <- median(data)
print(median.result)

lambda = c(0.1, 1)
par(mfrow = c(1, 3))
qqnorm(data)

results = c()

for (i in lambda) {
  ex = rexp(200, rate = i)
  control = data
    
  # estimate the parameters
  fit1 <- fitdistr(ex, "exponential") 
  fit2 <- fitdistr(control, "exponential")
  
  # goodness of fit test
  res = ks.test(ex, "pexp", fit1$estimate) # p-value > 0.05 -> distribution not refused
  ks.test(control, "pexp", fit2$estimate) #  significant p-value -> distribution refused
  print(paste(str(res$p.value),"P-value"))
  # plot a graph to test whether data follows an exponential distribution
  hist(control, freq = FALSE, breaks = 100, xlab="Bill", main=paste("Lambda", i) )
  curve(dexp(x, rate = fit1$estimate), from = 0, col = "red", add = TRUE)
}

# hist(control, freq = FALSE, breaks = 100, xlab="Bill", main=paste("Lambda", i) )


