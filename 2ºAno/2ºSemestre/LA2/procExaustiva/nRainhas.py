import sys

'''
Considerar um tabuleiro de xadrez de dimensão n

Determinar se é possível posicionar n rainhas no tabuleiro sem que se ataquem mutuamente
'''

def complete (n, pos):
    return len(pos) == n

def ok(n, pos, x ,y):
    for(x0, y0) in pos:
        if y0==y or x0+y0==x+y or y0-x0==y-x: return False
    return True 

def extensions(n, pos):
    return[(len(pos),y) for y in range(n) if ok(n, pos, len(pos), y)]

def valid(n, pos):
    return True

def search(n):
    pos = []
    if aux(n, pos): return pos 

def aux(n, pos):
    if complete(n, pos): return valid(n, pos)
    for p in extensions(n, pos):
        pos.append(p)
        if aux(n, pos): return True
        pos.pop()
    return False

def main():
    n = sys.stdin.readline()
    print(search(int(n)))

main()