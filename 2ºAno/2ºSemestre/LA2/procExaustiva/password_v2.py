import sys
'''
Quando os candidatos são compostos por vários elementos (sequências, dicionários, etc) 
é possível usar uma técnica de enumeração diferente

Os candidatos são construídos incrementalmente acrescentando um elemento de cada vez 
até o candidato estar completo

Depois de testar um candidato completo ou abandonar um candidato parcial inviável, 
faz-se backtracking para explorar outras alternativas

Pode levar a ganhos de eficiência consideráveis
'''

#versao para listas
def complete(h,c):
    return l(c) == 4

def extensions(h,c):
    return [chr(x) for x in range(ord('A'), ord('Z')+1)]

def valid(h,c):
    return h == hash(c)

def search(h):
    c = []
    if aux(h,c): return c

def aux(h,c):
    if complete(h,c): return valid(h,c)
    for x in extensions(h,c):
        c.append(x)
        if aux(h,c): return True
        c.pop()
    return False
    