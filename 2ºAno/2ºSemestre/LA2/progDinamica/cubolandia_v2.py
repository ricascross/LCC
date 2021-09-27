import sys
import math
from pprint import pprint

def maneiras(S, m, n):
    t = [[0 for x in range(m)] for y in range(n+1)]

    for i in range(m):
        t[0][i] = 1
    for i in range(1, n+1):
        for j in range(m):
            
            x = t[i-S[j]][j] if i-S[j] >= 0 else 0
            y = t[i][j-1] if j >= 1 else 0
            t[i][j] = x+y

    
    return t[n][m-1]

def main():
    lista_denom = []
    for base in range(1, 22):
        lista_denom.append(int(math.pow(base, 3)))
    #print(lista_denom)



    inp = sys.stdin.readline().strip('\n')
    inp = int(inp)
    resultado = maneiras(lista_denom, len(lista_denom), inp)
    print(resultado)
main()