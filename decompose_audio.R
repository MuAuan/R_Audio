data <- read.csv("./industrial/nikkei_225_.csv",encoding = "utf-8") #sibou_csv

hz=18
IIP <- ts(data,start=c(2008),frequency=hz) #12

decompose_IIP <- decompose(IIP)

#install.packages("forecast")
library(forecast)
plot(as.ts(IIP))

trend_beer = ma(IIP, order = hz, centre = T) #12

#detrend_beer = IIP - trend_beer # -decompose_IIP$random
detrend_beer = IIP - decompose_IIP$trend -decompose_IIP$random
plot(decompose_IIP$trend)
plot(decompose_IIP$random)
plot(decompose_IIP$seasonal[0:72])
plot(detrend_beer[0:72])

#m_beer = t(matrix(data = detrend_beer, nrow = 4)) #12
m_beer = t(matrix(data = decompose_IIP$seasonal, nrow = hz)) #12

seasonal_beer = colMeans(m_beer, na.rm = T)
plot(as.ts(rep(seasonal_beer,3)))

write.csv(as.ts(rep(seasonal_beer,130)), file = 'decompose_seasonal130.csv')

ds <- read.csv(file = 'decompose_seasonal130.csv')
print(ds[2])
print(max(abs(ds[2])))
ds_w = Wave(32678/max(abs(ds[2]))*ds[2], samp.rate = 150*hz, bit=16)
play(ds_w)
file_n <- paste('ds_',hz,'.wav')
writeWave(ds_w, file_n)

