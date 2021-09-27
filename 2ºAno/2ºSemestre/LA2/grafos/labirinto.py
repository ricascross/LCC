import sys

def adj(mapa, v):
    adjs = [(v[0]-1,v[1]), (v[0],v[1]+1), (v[0]+1,v[1]), (v[0],v[1]-1)]
    res = []
    for (x,y) in adjs:
        if x>=0 and x < len(mapa) and y>=0 and y<len(mapa[x]):
            if mapa[x][y]==' ':
                res.append(((x,y),1))
    return res

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
    txt = sys.stdin.readlines()
    dim = int(txt[0])    
    mapa = txt[1:]

    
    grafo = {}
    for x in range(0, dim):
        for y in range(0, dim):
            grafo[(x,y)] = adj(mapa, (x,y)) 

    
    travessia, distancias = dijkstra(grafo, (0,0))

    
    print(distancias[(dim-1 ,dim-1)])

main()
