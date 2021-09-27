import sys

'''
Um sistema tem passwords de 4 caracteres maiúsculos

Por questões de segurança só é guardado e comparado o hash da password

Um hacker rouba o ficheiro com os hashes

Dado um hash h quer descobrir a respectiva password usando pesquisa exaustiva

Os candidatos a solução são todas as sequências possíveis de 4 caracteres maiúsculos
'''

def first(h):
    return ['A']*4

def next(h,c):
    i = len(c) -1
    while i>=0 and c[i] == 'Z':
        c[i] = 'A'
        i = i-1
    if i < 0:
        return None
    c[i] = chr(ord(c[i])+1)
    return c

def valid(h,c):
    return h == hash(c)

def search(h):
    c = first(h)
    while(c != None):
        if valid(h,c):
            return c
        c = next(h,c)

