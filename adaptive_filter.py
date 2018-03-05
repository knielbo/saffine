import csv
import numpy as np

# filters
import detrending_method as dm
# import detrending_coeff as dc

# for testing
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings('ignore')

"""
adaptive smoothing filter for time series

order of integration: I(d), of a time series is a summary statistic,
which reports the minimum number of differences required to obtain a covariance
stationary series
"""
def qdp(ts):
    """ quick and dirty signal plotting for testing
    """
    plt.figure()
    #plt.plot(signal[:1000],'k-')
    plt.plot(ts,'k-')
    plt.xlabel('$t$')
    plt.ylabel('$F(t)$')
    plt.show()
    plt.close()

def integrate_ord1(ts):
    """
    first order integration of time series (list or numpy array) ts
    """
    return np.cumsum(ts) - np.mean(ts)

def normalize(ts, scl01 = False):
    ts01 = (ts - np.min(ts)) / (np.max(ts) - np.min(ts))
    ts11 = 2 * ts01 -1
    if scl01:
        return ts01
    else:
        return ts11

## DATA
with open('DATA/persist.csv', 'r') as f:
    reader = csv.reader(f)
    signal = [float(i) for i in list(reader)[0]]


# if __name__ == '__main__':
data = integrate_ord1(signal)# fBm
#data = signal# fWn
# qdp(data)# test 1

# parameters
n = len(data);# int for doc
w = int(4 * np.floor(n/20) + 1);# int for doc
# format
X = np.mat([float(x) for x in data])
# filtering
#color = ["blue","red","green"]
plt.figure()
for i in range(1,5):
    noise_ww_1, trend_ww_1 = dm.detrending_method(X, w, i);
    # zero2one
    #trend_ww_1 = (trend_ww_1 - np.min(trend_ww_1))/(np.max(trend_ww_1)-np.min(trend_ww_1))
    #trend_ww_1 = 2 * trend_ww_1 - 1
    #plt.plot(X.T,'r')
    plt.plot(normalize(trend_ww_1).T, label = str(i))#,color[i - 1])

#y = (X - np.min(X)) / (np.max(X) - np.min(X))
#y = 2 * y -1
plt.plot(normalize(X).T,':k', label = 'signal')
plt.legend()
plt.xlabel('$t$')
plt.ylabel('$F(t)$')
plt.savefig('FIGURES/fBm_trends.png')
plt.close()
