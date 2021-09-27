import sys
nomes = {}
a=sys.stdin.readline().strip("\n")

while (a[0] != '-'):
	(x,y)=a.split(" ",1)
	nomes[y] = x
	a=sys.stdin.readline().strip("\n")

freq = {}
a=sys.stdin.readline().strip("\n")

while (a!=""):
	if a in freq:
        freq[a] = freq[a] + 1
    else:
        freq[a] = 1
	a=sys.stdin.readline().strip("\n") 

dic_ordenado = sorted(freq.items())
print(dic_ordenado)




