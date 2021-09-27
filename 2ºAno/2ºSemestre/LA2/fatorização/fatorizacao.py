import sys

def fatorizacao(n):
    i = 2
    factors = []
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
            factors.append(i)
    if n > 1:
        factors.append(n)
    return factors

def main():
    val = sys.stdin.readline()
    lista = fatorizacao(int(val))
    for i in lista:
        print(i)

main()
