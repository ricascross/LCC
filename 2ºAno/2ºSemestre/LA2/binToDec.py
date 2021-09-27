import sys
from math import pow

def converter(valor_Binario):
    i = len(valor_Binario)-1
    result = 0
    for val in valor_Binario:
        if (val != '0'):
            result += (2**i)
        i -=1
    return result



def main():
    valor_Binario = sys.stdin.readline().strip("\n")

    while (valor_Binario != ""):
        result = converter(valor_Binario)
        print(result)
        valor_Binario = sys.stdin.readline().strip("\n")

    
main()




