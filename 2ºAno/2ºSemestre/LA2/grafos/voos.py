import sys

def parse(adj):
    for l in sys.stdin:        
        o,d,w = l.split()        
        if o not in adj:            
            adj[o] = []        
        if d not in adj:            
            adj[d] = []        
        adj[o].append((d,int(w)))        
        adj[d].append((o,int(w)))
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
    origem,destino = sys.stdin.readline().split(" ")
    origem = origem.strip()
    destino = destino.strip()
    
    adj = {}
    grafo = parse(adj)
    travessia, pesos  = dijkstra(grafo, origem)
    
    

    custo = pesos[destino]
    print(custo)

main()


