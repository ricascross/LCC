import sys
import collections



def fazerDicionario(dicio, lista):
    
    for palavra in lista:
        if palavra not in dicio:
            dicio[palavra] = []
            
        dicio[palavra] = lista.count(palavra)
    #print(dicio)
    return dicio
    




def main():
    dicio = {}
    lista = []
    flat_lista = []
    for line in sys.stdin:
        lista = line.strip('\n').split()
        for sublist in lista:
                flat_lista.append(sublist)
    flat_lista.sort()
    resultado = fazerDicionario(dicio,flat_lista)
    resultado = sorted(resultado.items(), key=lambda kv: kv[1], reverse=True)
    
    for item in resultado:
        print(item[0]+": "+str(item[1]))  
    
    
    
    
    


main()