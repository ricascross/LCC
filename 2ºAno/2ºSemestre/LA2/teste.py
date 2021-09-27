import sys

def fazerDicionario(dicio, lista):
    i=0
    for palavra in lista:
        if palavra not in dicio:
            dicio[palavra] = []
        dicio[palavra] = i+1
    print(dicio)
    




def main():
    txt = sys.stdin.readlines()
    lista_separados = [' ','\n']
    trans = {ord(i): '' for i in lista_separados} # mapear codigo ascii de cada caracter para o seu substituto, neste caso nada...    
    for idx, val in enumerate(txt):
        txt[idx][0] = val[0].translate(trans)
    print(txt)

main()
    