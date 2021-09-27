import sys
nomes = {}
a=sys.stdin.readline().strip("\n")

while (a[0] != '-'):
	(x,y)=a.split(" ",1)
	nomes[x] = y
	a=sys.stdin.readline().strip("\n")

notas = {}
a=sys.stdin.readline().strip("\n")

while (a!=""):
	(x,y) = a.split(' ',1)
	notas[x] = y
	a=sys.stdin.readline().strip("\n") 

res=[]
for x in nomes.keys():
	if x in notas:
		n = float(notas[x])
		if n >= 9.5:
			res.append((nomes[x],x,round (n)))
		else: 
			res.append((nomes[x],x,"R"))
			
	else:
		res.append((nomes[x] ,x,"F"))
res.sort()

for (no,num,nota) in res:
	print(num,no,":",nota)



