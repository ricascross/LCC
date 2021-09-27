import sys

def parse(adj):
    for l in sys.stdin:
        l = l.strip('\n')
        l = l.split()
        for country in l:
            if country not in adj:
                adj[country] = []
            for anotherCountry in l:
                if country != anotherCountry and anotherCountry not in adj:
                    adj[country].append(anotherCountry)
    return adj

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

def main():
    adj = {}
    fork = parse(adj)
    
    tamanhosTravessias = []
    for pais in fork:
        travessiaPais = bfs(fork, pais)
        tamanhoTravessia = len(travessiaPais) + 1
        tamanhosTravessias.append(tamanhoTravessia)
        
    if len(tamanhosTravessias) > 0:
        
        print(max(tamanhosTravessias))
    else:
        print(0)

main()