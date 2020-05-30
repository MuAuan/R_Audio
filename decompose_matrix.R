data <- read.csv("./industrial/nikkei_225_.csv",encoding = "utf-8")

IIP <- ts(data,start=c(2020001),frequency=7)
plot(head(IIP))

m_beer = t(matrix(data = IIP, nrow = 7)) #4
plot(m_beer)

seasonal_beer = colMeans(m_beer, na.rm = T)
plot(as.ts(rep(seasonal_beer,12)))

random_beer = IIP - seasonal_beer
plot(as.ts(IIP))
plot(as.ts(random_beer))
recomposed_beer = seasonal_beer+random_beer
plot(as.ts(recomposed_beer))
