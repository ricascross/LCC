import sys
import math

def maneiras(lista_denom, size, inp):
    if inp ==0: return 1
    if inp < 0: return 0
    if size <=0 and inp >=1: return 0
    return maneiras(lista_denom, size-1, inp) + maneiras(lista_denom, size, inp-lista_denom[size-1])



def main():
    lista_denom = []
    for base in range(1, 22):
        lista_denom.append(math.pow(base, 3))
    #print(lista_denom)



    inp = sys.stdin.readline().strip('\n')
    inp = int(inp)
    resultado = maneiras(lista_denom, len(lista_denom), inp)
    print(resultado)
main()