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

origem = sys.stdin.readline().split()[0]
adj = {}
parse(adj)
print(dijkstra(adj,origem))