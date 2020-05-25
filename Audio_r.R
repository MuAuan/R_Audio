#library(tuneR) #load tuenR package

#library(audio)
s7<-readWave("mywave.wav", from = 1, to = 5, units = "seconds")
print(s7)
s10<-load.wave("mywave.wav")
play(s10)

#s11<-load.wave("w_.wav")
#print(s11)
#play(s11)

#play('mywave.wav', 'play')

#make a simple sine wave and play
t = seq(0, 1, 1/800) #times in seconds if sample for 3 seconds at 8000Hz
u = (2^15-1)*sin(2*pi*440*t) #440 Hz sine wave that lasts t length seconds (here, 3 seconds)
write.csv(u,"./industrial/u_.csv")
w <- Wave(u, samp.rate = 800, bit=16) #make the wave variable
writeWave(w, filename = "w.wav")
s11<-load.wave("w.wav")
play(s11) #, 'play') #play the wave data by the player, 'play' pl

