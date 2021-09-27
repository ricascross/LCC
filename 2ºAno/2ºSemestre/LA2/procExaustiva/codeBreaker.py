import sys
import os
from pprint import pprint 

#lê a base de dados e adiciona as palavras todas a uma lista
'''
def readDataBase():
    dict_words_db = {}
    file_db = open("wordDataBase.txt","r")
    for line in file_db:
        word = line.strip("\n")
        tam = len(word)
        dict_words_db.setdefault(tam, [])
        dict_words_db[tam].append(word)
    return dict_words_db
'''
def readDataBase():
    list_words_db = []
    file_db = open("wordDataBase.txt","r")
    for line in file_db:
        word = line.strip("\n")
        list_words_db.append(word)
    #print(list_words_db)    
    return list_words_db
#lê o input
def read_cryptWord():
    word = sys.stdin.readline().strip("\n")
    return word

#subs -> substituicoes, cripto -> criptograma
def estende(subs, cripto, word):
    s = dict(subs)
    if len(cripto) != len(word): return None
    for i in range(len(word)):
        if cripto[i] in s:
            if s[cripto[i]] != word[i]: return None
        else:
            if word[i] in s.values(): return None
            s[cripto[i]] = word[i]
    return s

#dá todas as possibilidades de formar uma palavra
def estendeMul(subs, pal, words):
    for w in words:
        new_s = estende(subs,pal,w)
        if new_s: yield new_s

def extrai_palavras(txt):
    list_of_word = []
    pal = ""
    for i in range(len(txt)):
        if ord(txt[i]) in range(97,123):
            pal += txt[i]
        else:
            list_of_word.append(pal)
            pal = ""
    #print(list_of_word)
    return list_of_word



def solucoes(s, pals, words):
    if len(pals) == 0: yield s 
    for new_s in estendeMul(s,pals[0], words):
        #print(new_s)
        for new_new_s in solucoes(new_s, pals[1:], words):
            #print(new_new_s)
            yield new_new_s
    

def proc(txt,word_db):
    xs = extrai_palavras(txt)
    count = 0
    for s in solucoes({}, xs, word_db):
        count +=1
    #print (count)

def main():
    dict_of_words = readDataBase()
    word = read_cryptWord()
    print(proc(word, dict_of_words))

main()