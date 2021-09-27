import sys

def parse(adj):
    for l in sys.stdin:
        o,d = l.split()
        if o not in adj:
            adj[o] = []
        if d not in adj:
            adj[d] = []
        adj[o].append(d)
        adj[d].append(o)
    return adj
       
#testa se um candidato c está completo
def complete(adj,c):
    return len(adj) == len(c)


#enumera as extensões válidas para o candidato parcial c
def extensions(adj, c):
    i = list(adj.keys())[len(c)]
    cv = [c[x] for x in adj[i] if x in c]
    result = [(i,x) for x in range(len(adj)) if x not in cv]
    return result

#testa se um candidato c é uma solução válida para p
def valid(adj,c):
    return True
 

#procurar solução para p com procura exaustiva
def search(adj):
    c = {}
    if aux(adj,c): return c


def aux(adj, c):
    if complete(adj,c): return valid(adj,c)
    for i,x in extensions(adj,c):
        c[i] = x
        if aux(adj,c): return True
        c.pop(i)
    return False


    

def main():
    adj = {}
    result = parse(adj)
    adj = sorted(result.items(), key=lambda x: len(x[1]), reverse=True)
    
    final_graph = search(dict(adj))
    color_number = len(set(list(final_graph.values())))
    print(color_number)
    



main()