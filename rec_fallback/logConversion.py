import math

while True:
	num = int(input("Chips: "))
	e = int(input(str(num)+"e"))
	print(math.log10(num * math.pow(10,e)))
