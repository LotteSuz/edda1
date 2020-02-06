# light1879.txt = Michelson, 100 experiments, measurements in km/sec minus 299000
# light1882.txt = Michelson, 23 experiments, measurements in km/sec minus 299000
# light.txt = Newcomb, 20-20-26 experiments, of the passage time it took light to travel the distance 7.442 km: 
#             from the original times in microseconds measured by Newcomb first 24.8 was subtracted, after 
#             which the results were multiplied with 1000.

# investigate the normality of all three datasets

michelson_79 = read.delim("data/light1879.txt", header = FALSE, sep = " ", dec = ".")
print(michelson_79)