import sys

def subseqsum(valor_alvo,s):
    #testa se uma subsequencia de "s" soma valor "alvo"
    solucoes = set([0]) #inicializa a 0
    for i in range(1,len(s)+1):
        solucoes = solucoes.union(map(lambda x: x+s[i-1], solucoes))
        #print("i=", i, "Solucoes=", solucoes)
    #print(valor_alvo in solucoes)
    return valor_alvo in solucoes


def main():
    #parsing do input
    lines = sys.stdin.readlines()
    valor_alvo = int(lines[0])
    conta = 0
    for l in lines[1:]:
        s = list(map(int,l.split()))
        conta  += subseqsum(valor_alvo, s)
    print(conta)
    
main()