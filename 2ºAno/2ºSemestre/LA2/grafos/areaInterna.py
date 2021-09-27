import sys

def bfs(mapa,o):
    count = 1
    discovered = []
    queue = []
    discovered.append(o)
    queue.append(o)
    while queue:
        c = queue.pop(0)
        for n in adj(mapa,c):
            if n not in discovered:
                discovered.append(n)
                count +=1
                queue.append(n)
    return count

def adj(mapa, v):
    """ devolve a lista de adjacentes de v """
    adjs = [(v[0]-1,v[1]), (v[0],v[1]+1), (v[0]+1,v[1]), (v[0],v[1]-1)]
    res = []
    for (x,y) in adjs:
        if x>=0 and x < len(mapa) and y>=0 and y<len(mapa[x]):
            if mapa[x][y]==' ':
                res.append((x,y))
    return res

def main():
    txt = sys.stdin.readlines()
    vx, vy = txt[0].split()
    vx = int(vx)
    vy = int(vy)
    mapa = txt[1:]
    print(bfs(mapa,(vx,vy)))

main()