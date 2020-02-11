B = 1000
par(mfrow=c(1,1))
telephone <- read.csv("telephone.txt", sep="")
data = telephone$Bills
hist(data, main="Billing frequency", xlab="Bill")
x=seq(0, max(data), length=B)
lines(x,dexp(x),type="l",col="blue",lwd=2)
t=median(data)

# 2. 
# Calculate median, this is the test statistic
tstar=numeric(B)
n = length(data)
for (i in 1:B){
  xstar=sample(data,replace=TRUE)
  tstar[i]= median(xstar) 
}
hist(tstar,prob=T, ylim=c(0,0.18),  main="True density curve of T (median), samples=1000", xlab="Billing") 
lines(density(tstar), type="l",col="blue", lwd=3)

# Dertemine p-value
pl=sum(tstar<t)/B
pr=sum(tstar>t)/B
p=2*min(pl,pr)
pl;pr;p

# Determine if data follows an exponential distribution
lambda = c(0.1, 1)
par(mfrow = c(1, 3))
qqnorm(data)

results = c()
p_values = c()
for (i in lambda) {
  
  # Generate surrogate datas ample
  ex = rexp(200, rate = i)
  control = data
    
  # estimate the parameters
  fit1 <- fitdistr(ex, "exponential") 
  fit2 <- fitdistr(control, "exponential")

  # goodness of fit test
  ks.test(ex, "pexp", fit1$estimate) # p-value > 0.05 -> distribution not refused
  res = ks.test(control, "pexp", fit2$estimate) #  significant p-value -> distribution refused
  p_values = c(p_values, res$p.value)
  
  # plot a graph to test whether data follows an exponential distribution
  hist(control, freq = FALSE, breaks = 30, xlab="Bill", main=paste("Lambda", i) )
  curve(dexp(x, rate = fit1$estimate), from = 0, col = "red", add = TRUE, lwd=3)
}
print(p_values)

# Calculate bootstrap confidence interval
y = data
B = 10^4;  d.re = numeric(B)
a.obs = mean(y);  n = length(y)
for (i in 1:B) {
  a.re = mean(sample(y, n, repl=T))
  d.re[i] = a.re - a.obs }
L.re = quantile(d.re, .025);  U.re = quantile(d.re, 0.975)
c(a.obs - U.re,  a.obs - L.re)


#5. test that the median bill is bigger or equal to 40 euro 
binom.test(sum(data>=40),200,p=0.5)
binom.test(sum(data<40),200,p=0.5) # Smaller than 40 euro

# Fraction of bills smaller than 10 euro
print(length(data[which(data<10)])/200)

