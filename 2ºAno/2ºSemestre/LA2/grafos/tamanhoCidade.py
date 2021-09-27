import sys

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

def dijkstra(adj,o):    
    queue = []    
    parent = {}    
    dist = {}
    for v in adj:        
        dist[v] = float("inf")        
        queue.append(v)    
    dist[o] = 0
    while queue:        
        u = min(queue,key=lambda x : dist[x])        
        queue.remove(u)
        for (v,w) in adj[u]:            
            alt = dist[u] + w            
            if alt < dist[v]:                
                dist[v] = alt                
                parent[v] = u
    return parent,dist

def main():

    adj = {}
    cidade = parse(adj)
    print (cidade)
    distancia = []

    for cruzamento in cidade:
        parent,dist = dijkstra(cidade,cruzamento)

        for c in dist:
            distancia.append(dist[c])
    print(max(distancia))

main()
