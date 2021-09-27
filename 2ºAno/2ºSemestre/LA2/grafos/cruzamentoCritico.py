import sys
import operator

def parse(adj):
    for l in sys.stdin:
        l = l.strip('\n')
        tamanho = len(l)
        o = l[0]
        d = l[(len(l))- 1]
        if o not in adj:
            adj[o] = []
        if d not in adj:
            adj[d] = []
        if (o == d):
            adj[o].append((d,tamanho))
        else:
            adj[o].append((d,tamanho))
            adj[d].append((o, tamanho))
    return adj

def main():
    adj = {}
    parsing = parse(adj)
    #print (adj)
    lista = []
    for cruz,criti in parsing.items():
        lista.append((cruz, len(criti)))
        #print (lista)
    lista.sort(key=operator.itemgetter(0))
    lista.sort(key =operator.itemgetter(1))
    

    for cruz,criti in lista:
        
        print(cruz,criti)

main()