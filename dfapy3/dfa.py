"""
(Monofractal) Detrended Fluctuation Analysis example
"""
import numpy as np
from acoustics.generator import noise
import matplotlib.pyplot as plt

n = 8000
whitenoise = noise(n, color = 'white')
pinknoise = noise(n, color = 'pink')

# fractional brownian noise
RW1 = np.cumsum(whitenoise - np.mean(whitenoise))
RW2 = np.cumsum(pinknoise - np.mean(pinknoise))

# root-mean-square variation of time series (typical TS approach)
## average variation in time series
## average amplitude is similar for two very different signals
RMS_white = np.sqrt(np.mean(np.power(whitenoise,2)))
RMS_pink = np.sqrt(np.mean(np.power(pinknoise,2)))
print("Average variation for white noise {} and pink noise {}".format(RMS_white,RMS_pink))

# Local Detrending: local RMS variation in the time series
ts = pinknoise
X = np.cumsum(ts - np.mean(ts))
scale = 1000;
m = 1
segments = int(np.floor(len(X)/scale))
index = []
fit = []
rms = []
for v in range(segments):
    idx_start = ((v) * scale)
    idx_stop = (v + 1) * scale
    index.append(range(idx_start,idx_stop))
    X_idx = X[index[v]]
    #print(list(index[v]))
    #print(X[index[v]])
    C = np.polyfit(list(index[v]), X_idx, m)
    fit.append(np.polyval(C, list(index[v])))
    rms.append(np.sqrt(np.mean((np.power(X_idx - fit[v],2)))))
    print(C)
    print(rms)
print('Overall RMS for local fits F = {}'.format(np.sqrt(np.mean(np.power(rms,2)))))

plt.figure()
plt.plot(X,'k')
for i in range(len(index)):
    plt.plot(list(index[i]),fit[i],':r')
    plt.plot(list(index[i]),fit[i] + rms[i] * 1,'-r')
    plt.plot(list(index[i]),fit[i] - rms[i] * 1,'-r')
plt.savefig('local_rms.png')
plt.close()

def local_detrend(ts, scale = 1000, m = 1):
    """ Compute RMS for local m-order fits to ts at length scale
    """
    X = np.cumsum(ts - np.mean(ts))
    segments = int(np.floor(len(X)/scale))
    index = []
    fit = []
    rms = []
    for v in range(segments):
        idx_start = ((v) * scale)
        idx_stop = (v + 1) * scale
        index.append(range(idx_start,idx_stop))
        X_idx = X[index[v]]
        C = np.polyfit(list(index[v]), X_idx, m)
        fit.append(np.polyval(C, list(index[v])))
        rms.append(np.sqrt(np.mean((np.power(X_idx - fit[v],2)))))
    return rms

print()
rms = local_detrend(whitenoise)
print('Overall RMS for local fits F = {}'.format(np.sqrt(np.mean(np.power(rms,2)))))
print()
# Monofractal detrended fluctuation analysis
## compute F for multiple segments sizes (otherwise small sample sizes/small scale
## by fast changing fluctuations and slow changing fluctuations will influence large sample size/large scale)
# ts = whitenoise# for code test
ts = noise(n, color = 'pink')
# step 1 DFA
scales = [np.power(2,i) for i in range(4,11)]
m = 1
F = []
for scale in scales:
    rms = local_detrend(ts, scale = scale, m = 1)
    F.append(np.sqrt(np.mean(np.power(rms,2))))

# step 2 DFA
C = np.polyfit(np.log2(scales),np.log2(F),1)
H = C[0]
print('H = {}'.format(H))
regline = np.polyval(C,np.log2(scales))

plt.figure()
plt.plot(np.log2(scales),np.log2(F),'ro',np.log2(scales),regline,'k-')
plt.title('$H = {}$'.format(round(H,2)))
plt.xlabel('$log_{2}w$')
plt.ylabel('$log_{2}F(w)$')
plt.savefig('hurst_fit.png')
plt.close()

def mono_dfa(ts, scales = [], m = 1):
    """ monofractal detrended fluctuation analysis
    """
    if not scales:
        scales = [np.power(2,i) for i in range(4,11)]
    F = []
    for scale in scales:
        rms = local_detrend(ts, scale = scale, m = 1)
        F.append(np.sqrt(np.mean(np.power(rms,2))))
    C = np.polyfit(np.log2(scales), np.log2(F),1)
    H = round(C[0],2)
    regline = np.polyval(C,np.log2(scales))
    # return to original scale
    x = [np.power(2,i) for i in np.log2(scales)]
    y = [np.power(2,i) for i in np.log2(F)]
    return {'w': x, 'F(w)': y, 'H': H, 'fit': regline}

dfa_res = mono_dfa(ts)
for key in dfa_res.keys():
    print('{} = {}'.format(key, dfa_res[key]))

#####
