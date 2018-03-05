from numpy import * 
import numpy as np
# from numba import jit

# @jit
def integrate1(data):
	data = data - np.mean(data)
	nrows = shape(data)[0]
	ncols = shape(data)[1]
	data_int = mat(zeros((nrows,ncols)))
	data_int[0,0] = data[0,0]
	for i in range(1,ncols-1):
		data_int[0,i] = data_int[0,i-1] + data[0,i]	
		
	return data_int
