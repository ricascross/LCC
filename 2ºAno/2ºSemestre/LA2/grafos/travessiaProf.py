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

def dfs_aux (adj, o, discovered, parent):
    discovered.append(o)
    for d in adj[o]:
        if d not in discovered:
            parent[d] = o
            dfs_aux(adj, d, discovered, parent)
    return parent


def dfs (adj, o):
    return dfs_aux(adj, o, [], {})

origem = sys.stdin.readline().split()[0]
adj = {}
parse(adj) 
print(dfs(adj,origem))