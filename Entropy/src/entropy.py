"""this file mainly deal with the entropy of the letters"""
import math

def entropy(p) :
	if p == 0 or p == 1 :
		return 0
	return -(p * math.log(p, 2))

def cal_res(filename, EN_OR_CN) :
	f = open(filename)
	sum = 0
	while True :
		line = f.readline()
		if not line :
			break
		if EN_OR_CN == 'EN' :
			p = line[ : line.index('%') - 1]
		else :
			p = line
		p = float(p)
		sum += entropy(p / 100)
	f.close()
	return sum

EN_entropy = cal_res("EN_entropy.txt", 'EN')
CN_entropy = cal_res("CN_entropy.txt", 'CN')
out = open("Final_Result.txt", 'w')
out.write("The entropy of English letters is " + str(EN_entropy) + '\n')
out.write("The entropy of Chinese characters is " + str(CN_entropy) + '\n')
out.close()
