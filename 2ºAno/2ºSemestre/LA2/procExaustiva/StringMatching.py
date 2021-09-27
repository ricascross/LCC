import sys

'''
Dadas duas strings s e m, determinar em que posição m ocorre em s unsando pesquisa exaustiva

Os candidatos a solução são todas as posições de s onde m pode ocorrer
'''

def first(s,m):
    return 0

def next(s,m,c):
    if c < len(s):
        return c+1

def valid(s,m,c):
    return s[c_c+len(m)] == m

def search(s,m):
    c = first(s,m)
    while (c != None):
        if valid(s,m,c):
            return c
        c = next(s,m,c)