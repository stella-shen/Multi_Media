"""this file deals with the file ChineseCharFrequencyG.txt
and output the data I need"""

def cal_CN(input, output) :
	infile = open(input, encoding='utf8')
	needed_data = []
	while True :
		line = infile.readline()
		if not line :
			break
		vals = line.split()
		needed_data.append(vals[3])
	infile.close()
	outfile = open(output, "w")
	for i in range(len(needed_data)) :
		if i == 0 :
			data = float(needed_data[i])
		else :
			data = float(needed_data[i]) - float(needed_data[i - 1])
		outfile.write(str(data) + '\n')
	outfile.close()

cal_CN("ChineseCharFrequencyG.txt", "CN_entropy.txt")
