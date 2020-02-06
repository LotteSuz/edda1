library(stats)

n=30
m=30
mu=180
# nu=175
sd=15
samples=1000
# grid = seq(175,185,by=0.25)
# power = numeric(length(grid))
# power2 = numeric(length(grid))
power3 = numeric(length(grid))

for (i in 1:length(grid)){
p=numeric(samples)

    for (j in 1:samples) {
      # rnorm(number of observations,mean,sd)
      x=rnorm(n,mu,sd)
      y=rnorm(m,grid[i],sd)
      p[j]=t.test(x,y,var.equal=TRUE)[[3]]
    }

# power is the fraction of p values that are below 0.05
# absolute value of p values below 0.05: power = length(which(p < 0.05))
power3[i]=mean(p<0.05)
}

# code for the plot
dt <- data.frame(x=grid,val=c(power,power2,power3), variable=rep(c('n=m=30, mu=180 and sd=5','n=m=100, mu=180 and sd=5','n=m=30, mu=180 and sd=15'), each=41))
plot <- ggplot(data = dt, aes(x=x, y=val)) + geom_line(aes(colour=variable)) + labs(x = "Nu", y = "Power", tag="Figure 1", Title="Power as a function
                                                                                    of nu", colour="Parameters")
