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
            
    print(adj)

adj = {}
parse(adj)