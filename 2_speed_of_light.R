# light1879.txt = Michelson, 100 experiments, measurements in km/sec minus 299000
# light1882.txt = Michelson, 23 experiments, measurements in km/sec minus 299000
# light.txt = Newcomb, 20-20-26 experiments, of the passage time it took light to travel the distance 7.442 km: 
#             from the original times in microseconds measured by Newcomb first 24.8 was subtracted, after 
#             which the results were multiplied with 1000.

# include libraries
library(readr)

# mich_79 = c()
# # investigate the normality of all three datasets
# michelson_79 = read.table("data/light1879.txt", header=FALSE, sep="")
# p=numeric(100)
# for (item in michelson_79){
#   for (it in item){
#     print(it)
#     mich_79 = c(mich_79,it)
#   }
# }

# mich_82 = c()
# # investigate the normality of all three datasets
# michelson_82 = read.delim("data/light1882.txt", header=FALSE, sep="")
# p=numeric(100)
# for (item in michelson_82){
#   for (it in item){
#     if (!is.na(it)){
#       mich_82 = c(mich_82,it)
#     }
#   }
# }
# plotNormalHistogram(mich_82)
newcomb = c()
# investigate the normality of all three datasets
newc = read.delim("data/light.txt", header=FALSE, sep="\n")
for (i in 1:66){
      newcomb = c(newcomb,newc[i])
}
