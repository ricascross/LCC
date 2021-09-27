import sys

def dictionaryContains(prefix, list_words):
    n = len(list_words)
    for i in range(n):
        if list_words[i] == prefix:
            return True
    return False



def word_break(phrase_without_spaces, size_max, final_string, list_words):
    
    result = ""
    for i in range(size_max+1):
        prefix = phrase_without_spaces[i:]
        #print(prefix)
        res = dictionaryContains(prefix, list_words)
        #print(res)
        if res:
            if i == size_max:
                #print(i, size_max)
                result += prefix
                print(result)
                break
            word_break(phrase_without_spaces[i:size_max-i], size_max-i, result+prefix+" ", list_words)
            
    
    
def main():
    list_words = []
    
    
    txt = sys.stdin.readlines()
    phrase_without_spaces = txt[0].strip('\n')
    size_max = len(phrase_without_spaces)

    for word in txt[1:]:
        list_words.append(word.strip('\n'))
    
    word_break(phrase_without_spaces, size_max, "", list_words)
    #resultado, list_index = subset_sum(list_size, size_max,len(list_size)-1)
    #print(resultado, list_index)
    
    
    
    

main()

