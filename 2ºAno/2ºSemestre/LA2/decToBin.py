import sys

def decToBin(x):
    return int(bin(x)[2:])


def main():
    valor_Decimal = sys.stdin.readline().strip('\n')
    while(valor_Decimal != ''):
        result = decToBin(int(valor_Decimal))
        print(result)
        valor_Decimal = sys.stdin.readline().strip('\n')

main()
