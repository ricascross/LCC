import sys
from pprint import pprint

def adj(size, v):
    x = v[0]
    y = v[1]
    adjs = [(x+2, y+1), (x+2, y-1), 
            (x+1, y+2), (x+1, y-2), 
            (x-2, y+1), (x-2, y-1), 
            (x-1, y+2), (x-1, y-2)]
    result = []
    for (x,y) in adjs:
        if x>=0 and x < size and y>=0 and y < size:
            result.append(((x,y), 1))
    return result



def dijkstra(grafo, source, destiny):
    visited = set()
    queue = [source]
    dist = {
        source: 0
    }

    while queue:
        u = min(queue,key=lambda x : dist[x])

        if u == destiny:
            break

        queue.remove(u)

        for (v,w) in grafo[u]:
            if v not in visited:
                visited.add(v)
                queue.append(v)

            alt = dist[u] + w
            if v not in dist or alt < dist[v]:
                dist[v] = alt

    return dist


def make_board(size):
    board = {}
    
    for i in range(size):
        for j in range(size):
            if (i,j) not in board.keys():
                board[(i,j)] = adj(size, (i,j))
    
    return board

def main():
    # Obter dimensões do tabuleiro
    size = int(sys.stdin.readline())
    
    board = {}
    board = make_board(size)

    positions = []
    for line in sys.stdin:
        new_line = str(line).strip()
        coords = new_line.split(" ")

        
        source =  (  int(coords[0]), int(coords[1]) )
        destiny = (  int(coords[2]), int(coords[3]) )

        positions.append((source, destiny))

    for (o, d) in positions:
        dists = dijkstra(board, o, d)
        print(dists[d])

main()