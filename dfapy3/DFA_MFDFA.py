"""
Monofractal and multifractal Detrended Fluctuation Analysis
"""
import numpy as np

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

def multi_dfa(ts, scale = [], q = [-5, -3, -1, 0, 1, 3, 5], m = 1):
    """ compute Hurst for set of q-order statistics for time series ts
    """
    if not scale:
        scale = [np.power(2,i) for i in range(4,11)]
    X = np.cumsum(ts - np.mean(ts))
    RMS = []
    qRMS = []
    segments = []
    Fq = np.zeros((len(q),len(scale)))
    RMS = [[] * len(q)] * len(scale)
    qRMS = [[0] * len(q)] * len(scale)
    for ns in range(len(scale)):
        segments.append(int(np.floor(len(X)/scale[ns])))
        tmp = []
        for v in range(segments[ns]):
            idx_start = ((v) * scale[ns])
            idx_stop = (v + 1) * scale[ns]
            Index = range(idx_start,idx_stop)
            C = np.polyfit(Index,X[Index],m)
            fit = np.polyval(C,Index)
            tmp.append(np.sqrt(np.mean(np.power(X[Index] - fit, 2))))
        RMS[ns].append(tmp)
        for nq in range(len(q)):
            qRMS[nq][ns] = np.power(RMS[ns][ns],q[nq])
            if q[nq] != 0:
                Fq[nq,ns] = np.power(np.mean(qRMS[nq][ns]),1/q[nq])
            elif q[nq] == 0:
                Fq[nq,ns] = np.exp(0.5 * np.mean(np.log(np.power(RMS[ns][ns],2))))
    Hq = np.zeros(len(q))
    qRegLine = []
    for nq in range(len(q)):
        C = np.polyfit(np.log2(scale),np.log2(Fq[nq,:]),1)
        Hq[nq] = round(C[0],2)
        qRegLine.append(np.polyval(C,np.log2(scale)))
    return Hq

# test
import csv
with open('ts.csv', 'r') as f:
    reader = csv.reader(f)
    ts = [float(i) for i in list(reader)[0]]

baseline = mono_dfa(ts, m = 1)
print("baseline H = {}".format(baseline['H']))
print("test H = {}".format(np.mean(multi_dfa(ts))))
