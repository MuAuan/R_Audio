import pandas as pd
import statsmodels.api as sm
from statsmodels.tsa.seasonal import STL
#from sklearn.metrics import mean_squared_error
#from statsmodels.tsa.ar_model import AR
import matplotlib.pyplot as plt
#import seaborn as sns
# include below line if you are using Jupyter Notebook
#%matplotlib inline
# Set figure width to 12 and height to 9
plt.rcParams['figure.figsize'] = [12, 9]
df = pd.read_csv('sibou_.csv') #,sep='\t') #, index_col='Date')
#df.index = pd.to_datetime(df.index)
#df.sort_index(inplace=True)
#df = df.resample('W').last()
series = df['Price']
print(series)

cycle, trend = sm.tsa.filters.hpfilter(series, 144)
fig, ax = plt.subplots(3,1)
ax[0].plot(series)
ax[0].set_title('Price')
ax[1].plot(trend)
ax[1].set_title('Trend')
ax[2].plot(cycle)
ax[2].set_title('Cycle')
plt.show()
plt.close()

stl=STL(series, period=12, robust=True)
result = stl.fit()
chart = result.plot()
plt.show()
plt.close()

chart1= result.plot(observed=False, resid=False)
chart2= result.plot(trend=False, resid=False)
plt.show()
plt.close()
pl1 = result.observed
pl2 = result.trend
pl3 = result.seasonal
pl4 = result.resid
print(pl2)
import csv
with open('sample_pl2.csv', 'w') as f:
    writer = csv.writer(f, delimiter='\n')
    writer.writerow(pl2)
plt.plot(pl1)
plt.plot(pl2)
plt.plot(pl3)
plt.plot(pl4)
plt.show()
plt.close()

pl5 = result.seasonal.plot()
plt.show()
plt.close()

import wave
import numpy as np
import struct
import pyaudio

fs = 800 #サンプリング周波数
#サイン波を-32768から32767の整数値に変換(signed 16bit pcmへ)
swav = [int(x ) for x in pl3] #32767
#バイナリ化
binwave = struct.pack("h" * len(swav), *swav)
#サイン波をwavファイルとして書き出し
w = wave.Wave_write("pl3_seasonal.wav")
params = (1, 2, fs, len(binwave), 'NONE', 'not compressed')
w.setparams(params)
w.writeframes(binwave)
w.close()
