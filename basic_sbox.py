from math import log2

def ddt(m,n,sbox):
	'''
	generate the Differential Distribution Table of a m-bit to n-bit sbox
	'''
	table = [[0] * (1<<n) for _ in range(1<<m)]
	for i in range(1<<m):
		for j in range(1<<m):
			xorin = i^j
			xorout = sbox[i]^sbox[j]
			table[xorin][xorout] += 1
	# for i in range(1<<m):
	# 	print(table[i])
	return table

def wt(s):
	'''
	return the hamming weight of an integer
	'''
	st = bin(s)[2:]
	res = 0
	for item in st:
		if item == '1':
			res += 1
	return res

def branch_number(m,n,table):
	'''
	return the branch number of a ddt/lat
	'''
	res = []
	for i in range(1,1<<m):
		for j in range(1,1<<n):
			if (table[i][j] != 0):
				res.append(wt(i)+wt(j))
	return min(res)

def uni(m,n,sbox):
	'''
	compute the Uniformity of a m-bit to n-bit sbox
	'''
	ddt_table = ddt(m,n,sbox)
	u = []
	for i in range(1,1<<m):
		u.append(max(ddt_table[i]))
	return max(u)

def inner_product(x,y,m):
	'''
	m-bit x and m-bit y do the inner product
	'''
	res = 0
	xx = bin(x)[2:].zfill(m)
	yy = bin(y)[2:].zfill(m)
	for i in range(m):
		if (xx[i] == '1') and (yy[i] == '1'):
			if (res == 1):
				res = 0
			else:
				res = 1
	return res

def lat(m,n,sbox):
	'''
	generate the Linear Approximation Table of a m-bit to n-bit sbox
	'''
	table = [[-(1<<(m-1))] * (1<<n) for _ in range(1<<m)]
	for i in range(1<<m):
		for j in range(1<<n):
			for x in range(1<<m):
				if (inner_product(i,x,m) == inner_product(j,sbox[x],n)):
					table[i][j] += 1
	# for i in range(1<<m):
	# 	print(table[i])
	return table

def lin(m,n,sbox):
	'''
	compute the Linearity of a m-bit to n-bit sbox
	'''
	lat_table = lat(m,n,sbox)
	u = []
	for i in range(1,1<<m):
		u.append(max(lat_table[i][1:]))
		u.append(min(lat_table[i][1:]))
	ma = max(u)*2
	mi = -min(u)*2
	return (ma if ma>=mi else mi)

def partial_less_than(x,n):
	'''
	generate all the numbers that are partial order less than n-bit x
	'''
	lis = []
	xx = bin(x)[2:].zfill(n)
	flag = 0
	for i in range(1<<n):
		ii = bin(i)[2:].zfill(n)
		for j in range(n):
			if (xx[j] == '0'):
				if (ii[j] != '0'):
					flag = 1
					break
		if (flag == 0):
			lis.append(i)
		flag = 0
	return lis

def truth_table(m,n,sbox):
	'''
	compute the truth table of a m-bit to n-bit sbox
	'''
	table = [[0]*(1<<m) for i in range(n)]
	for i in range(1<<m):
		out = bin(sbox[i])[2:].zfill(n)
		for j in range(n):
			if (out[j] == '1'):
				table[j][i] = 1
			else:
				table[j][i] = 0
	return table

def anf(table):
	'''
	compute the algebraic normal form of a boolean function from its truth table
	'''
	L = len(table)
	m = int(log2(L))
	res = [0]*L
	for i in range(L):
		temp = partial_less_than(i,m)
		for j in temp:
			if (table[j] == 1):
				if (res[i] == 1):
					res[i] = 0
				else:
					res[i] = 1
	return res

def to_print_anf(f):
	'''
	when we get a ANF for a boolean function, how to print it?
	and compute the Algebraic Degree of the ANF
	'''
	L = len(f)
	m = int(log2(L))
	if (f[0] == 1):
		ff = "1"
	else:
		ff = ""
	deg = 0
	for i in range(1,L):
		index = i
		if (f[i] == 1):
			for j in range(m):
				r = m - 1
				d = 0
				temp = ""
				while r >= 0 :
					if (index & 0x1):
						temp = "x" + str(r) + temp
						d += 1
					r -= 1
					index >>= 1
				if (temp):
					ff += " + " + temp
					deg = max([deg, d])
	return (ff[3:] if ff[0] == " " else ff, deg)
		
def degree(m,n,sbox):
	'''
	compute the Algebraic Degree of a m-bit to n-bit sbox
	'''
	res = []
	table = truth_table(m,n,sbox)
	for i in range(n):
		res.append(to_print_anf(anf(table[i]))[1])
	return tuple(res)
		
if __name__ == '__main__':
	# s=[0x6,0x5,0xc,0xa,0x1,0xe,0x7,0x9,0xb,0x0,0x3,0xd,0x8,0xf,0x4,0x2]
	# print("the Uniformity of RECTANGLE is ", uni(4,4,s))
	# print("the Linearity of RECTANGLE is ", lin(4,4,s))
	# print("the Algebraic Degree of RECTANGLE is ", degree(4,4,s))
	# table = truth_table(4,4,s)
	# for i in range(4):
	# 	print(to_print_anf(table[i]))

	# ss=[0, 15, 5, 10, 9, 6, 12, 3, 2, 13, 7, 8, 11, 4, 14, 1]
	# st=[0, 15, 8, 7, 13, 2, 5, 10, 11, 4, 3, 12, 6, 9, 14, 1]
	# ss = [0, 5, 3, 6, 5, 0, 6, 3]
	# st = [0, 7, 2, 5, 5, 2, 7, 0]
	ss = [0, 15, 5, 10, 9, 6, 12, 3, 2, 13, 7, 8, 11, 4, 14, 1]
	st = [0, 7, 9, 14, 3, 4, 10, 13, 5, 2, 12, 11, 6, 1, 15, 8]
	
	n = 4
	print(lat(n,n,ss))
	print(ddt(n,n,ss))
	print(branch_number(n,n,lat(n,n,ss)))
	print(branch_number(n,n,ddt(n,n,ss)))
	# st = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
	print(lat(n,n,st))
	print(ddt(n,n,st))
	print(branch_number(n,n,lat(n,n,st)))
	print(branch_number(n,n,ddt(n,n,st)))
	


    