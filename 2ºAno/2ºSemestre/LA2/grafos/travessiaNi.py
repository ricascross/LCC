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

def bfs(adj,o):    
    parent = {}    
    discovered = []    
    queue = []    
    discovered.append(o)    
    queue.append(o)
    while queue:        
        c = queue.pop(0)
        for n in adj[c]:
            if n not in discovered:                
                discovered.append(n)                
                parent[n] = c                
                queue.append(n)
    return parent


origem = sys.stdin.readline().split()[0]
adj = {}
parse(adj)
print(bfs(adj,origem))
