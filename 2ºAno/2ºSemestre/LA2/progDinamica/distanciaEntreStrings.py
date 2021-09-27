import sys

#naive recursive
'''
def edit_distance(word_1,size_1, word_2, size_2):
    if size_1 == 0:
        return size_2
    if size_2 == 0:
        return size_1
    
    if word_1[size_1-1] == word_2[size_2-1]:
        return edit_distance(word_1,size_1-1,word_2,size_2-1)
    
    return 1 + min(edit_distance(word_1, size_1,word_2, size_2-1),         #remove
                   edit_distance(word_1, size_1-1,word_2, size_2),  #insert
                   edit_distance(word_1,size_1-1, word_2,size_2-1)) #replace
'''
#dynamic programming
def edit_distance(word_1,size_1, word_2, size_2):
    matrix = [[0 for x in range(size_2+1)] for x in range(size_1+1)]

    for i in range(size_1+1):
        for j in range(size_2+1):
            if i == 0:
                matrix[i][j] = j
            elif j == 0:
                matrix[i][j] = i
    
            elif word_1[i-1] == word_2[j-1]:
                matrix[i][j] = matrix[i-1][j-1]
            
            else:
                matrix[i][j] = 1 + min(matrix[i][j-1],
                                       matrix[i-1][j],
                                       matrix[i-1][j-1])
    return matrix[size_1][size_2]





def main():
    list_words = []
    for word in sys.stdin:
        list_words.append(word.strip('\n'))
    
    for word_1, word_2 in zip(list_words,list_words[1:]):
        if (word_2 == ''): break
        resultado = edit_distance(word_1,len(word_1), word_2, len(word_2))
        print(resultado)

main()