import sys


#parsing
#def adjacentes
#caminhos mais curtos
# produzir resultado


def adj(mapa, v):
    """ devolve a lista de adjacentes de v (dest e custo)"""
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
    dist[o] = 0
    queue.append(o)

    while queue:        
        u = min(queue,key=lambda x : dist[x])        
        queue.remove(u)
        for (v,w) in adj[u]:            
            alt = dist[u] + w                 #novo custo    
            if v in dist:  
                
            if alt < dist.get(v, float(inf)):                
                dist[v] = alt                
                parent[v] = u
    return parent,dist


#def parsing():


def main():
    txt = sys.stdin.readlines()
    dim = int(txt[0])
    mapa = txt[1:]
    print(dim)
    print(adj(mapa,(0,0)))

main()

    