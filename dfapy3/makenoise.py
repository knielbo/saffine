"""
write time series to csv for cross-platform testing
"""
import csv
import numpy as np
from acoustics.generator import noise

n = 8000
ts = noise(n, color = 'white')
print(ts)

with open('ts.csv', 'w') as f:
    wr = csv.writer(f)
    wr.writerow(ts)
