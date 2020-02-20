B = 1000
par(mfrow=c(1,1))
telephone <- read.csv("telephone.txt", sep="")
data = telephone$Bills

temp = data[data <= 50] 

shapiro.test(data)
df <- data.frame(cbind(data, index = 1:length(data)))
fit <- lm(data ~ index, data = df)

ggplot(data=telephone, aes(telephone$Bills)) + 
  geom_histogram(binwidth = 7) 


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

# 95% confidence interval
B=1000
data_median=median(telephone)
data=telephone
Tstar=numeric(B)
for(i in 1:B){
  Xstar=sample(data,replace=TRUE)
  Tstar[i]=mean(Xstar) 
}
Tstar25=quantile(Tstar,0.025)
Tstar975=quantile(Tstar,0.975)
sum(Tstar<Tstar25)
c(2*data_median-Tstar975,2*data_median-Tstar25) 


# Dertemine p-value
pl=sum(tstar<t)/B
pr=sum(tstar>t)/B
p=2*min(pl,pr)
pl;pr;p

# Determine if data follows an exponential distribution
control = data[data <= 50] 
qqnorm(control)

p_values = c()
n = 200
lamdas = seq(from = 0.0001, to = 1, length.out = 1000)
for (i in lamdas) {
  
  # Generate surrogate datas ample
  ex = rexp(n, rate = 0.021119)
    
  # estimate the parameters
  fit1 <- fitdistr(ex, "exponential") 
  fit2 <- fitdistr(data, "exponential")
  
  res1 = ks.test(ex, data) #  significant p-value -> distribution refused
  res1$p.value
  p_values = c(p_values, res1$p.value)
}
# Print v-values
p_values
max(p_values)
which(p_values==max(p_values))

# Check which lamda resulted in a fit
lamdas[22]

# Plot a graph
hist(data, freq = FALSE, breaks = 30, xlab="Bill", main=paste("Lambda", 0.021) )
curve(dexp(x, rate = fit1$estimate), from = 0, col = "red", add = TRUE, lwd=3)



# Calculate bootstrap confidence interval
y = medians
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

# Generate samples
medians = c()
for (i in 1:1000) {
  sample_median = median(sample(data, 100))
  medians[i] = sample_median
}
mean(medians)

data_temp = c()
index2 = c()
for (i in 1:200) {
  data_temp = c(data_temp, round(telephone$Bills[i]))
  index2 = c(index2, index[i]/4)
}



ggplot(data=telephone, aes(x=telephone$Bills, y = index2)) +
  geom_bin2d() +
  geom_density_2d(color="darkgrey", size = 1.5) +
  theme_grey(base_size = 21) +
  labs(y="Frequency", x="Bill", title="Distribution of bills") + 
  scale_fill_viridis_c()

temp = rexp(n = 200, rate = 30)

ggplot(data=telephone, aes(x=telephone$Bills)) +
  geom_histogram(binwidth = 6, color="black", alpha=0.4) +
  geom_freqpoly(binwidth = 6, color="red") +
  labs(x="Bill", y="Frequency", title="Distribution of bills") +
  theme_grey(base_size = 21)  




 

