data <- read.csv("./industrial/sibou_p.csv",encoding = "utf-8")

IIP <- ts(data,start=c(2008),frequency=12)
print("dim(IIP)")
print(dim(IIP))
print("head(IIP)")
print(head(IIP))

# —v‘f•ª‰ğ
pngFileName <- paste("./industrial/IIP_compose_sibou_random.png",sep="")
png(file=pngFileName,res=400, w=1000, h=600,pointsize=5)
decompose_IIP <-  decompose(IIP)
plot(decompose_IIP$random)
dev.off()

#install.packages("forecast")
library(forecast)
trend_beer = ma(IIP, order = 12, centre = T) #4
plot(as.ts(IIP))
lines(trend_beer)
plot(as.ts(trend_beer))

detrend_beer = IIP - trend_beer
plot(as.ts(detrend_beer))

m_beer = t(matrix(data = detrend_beer, nrow = 4))

#install.packages("fpp")
library(fpp)
data(ausbeer)
timeserie_beer = IIP # tail(head(ausbeer, 17*4+2),17*4-4)

ts_beer = ts(timeserie_beer, frequency = 12)
decompose_beer = decompose(ts_beer, "additive")

plot(as.ts(decompose_beer$seasonal))
plot(as.ts(decompose_beer$trend))
plot(as.ts(decompose_beer$random))
plot(decompose_beer)
seasonal_beer = colMeans(m_beer, na.rm = T)
plot(as.ts(rep(seasonal_beer,16)))

random_beer = IIP - trend_beer - seasonal_beer
plot(as.ts(random_beer))

recomposed_beer = trend_beer+seasonal_beer+random_beer
plot(as.ts(recomposed_beer))
