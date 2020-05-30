data <- read.csv("./industrial/sibou_.csv",encoding = "utf-8")

IIP <- ts(data,start=c(2008),frequency=12)
print("dim(IIP)")
print(dim(IIP))
print("head(IIP)")
print(head(IIP))

w_list <- c("seasonal", "random", "trend","observed")
decompose_IIP <- decompose(IIP)
for (i in w_list){
  if (i=="seasonal"){
    pngFileName <- paste("./industrial/decompose/IIP_compose_sibou_seasonal.png",sep="")
    png(file=pngFileName,res=400, w=800, h=500,pointsize=5)
    plot(decompose_IIP$seasonal) #seasonal cyclic random trend
    dev.off()
  }else if(i=="random"){
    pngFileName <- paste("./industrial/decompose/IIP_compose_sibou_random.png",sep="")
    png(file=pngFileName,res=400, w=800, h=500,pointsize=5)
    plot(decompose_IIP$random)
    dev.off()
  }else if(i=="trend"){
    pngFileName <- paste("./industrial/decompose/IIP_compose_sibou_trend.png",sep="")
    png(file=pngFileName,res=400, w=1000, h=600,pointsize=5)
    plot(decompose_IIP$trend)
    dev.off()
  }else if(i=="observed"){
    pngFileName <- paste("./industrial/decompose/IIP_compose_sibou_observed.png",sep="")
    png(file=pngFileName,res=400, w=1000, h=600,pointsize=5)
    plot(IIP)
    dev.off()
  }
}

#install.packages("forecast")
library(forecast)
plot(as.ts(IIP))

trend_beer = ma(IIP, order = 12, centre = T) #4
lines(trend_beer)
plot(as.ts(trend_beer))

detrend_beer = IIP - trend_beer
plot(as.ts(detrend_beer))

m_beer = t(matrix(data = detrend_beer, nrow = 12))
seasonal_beer = colMeans(m_beer, na.rm = T)
plot(as.ts(rep(seasonal_beer,13)))

random_beer = IIP - trend_beer - seasonal_beer
plot(as.ts(random_beer))

plot(decompose_IIP$random)

write.csv(as.ts(rep(seasonal_beer,1300)), file = 'decompose_seasonal1300.csv')

ds <- read.csv(file = 'decompose_seasonal1300.csv')
ds_w = Wave(32678/max(abs(ds))*ds, samp.rate = 8000, bit=16)
play(ds_w)
writeWave(ds_w, 'ds_w.wav')
