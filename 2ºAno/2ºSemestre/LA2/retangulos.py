import sys
'''
def make_rectangules(first_coordenates, second_coordenates):
    
    for y in range(second_coordenates[1]-first_coordenates[1]+1):
        for x in range(second_coordenates[0]-first_coordenates[0]+1):    
            print('#')
        

def main():
    aux_list = []
    for line in sys.stdin:
        line = line.strip('\n').split()
        line = list(map(int,line))
        first_coordenates = (line[0],line[1])
        second_coordenates = (line[2],line[3])
        make_rectangules(first_coordenates, second_coordenates)

main()
'''
import sys

def main():
    aux_list = []
    for line in sys.stdin:
        line = line.strip('\n').split()
        line = list(map(int,line))
        aux_list.append(list(line))
    #print(aux_list)

    max_x = 0
    max_y = 0
    for elem in aux_list:
        if elem[2] > max_x:
            max_x = elem[2]
        if elem[3] > max_y:
            max_y = elem[3]

    array = [[" " for x in range(max_y+1)] for y in range(max_x+1)]
    for elem in aux_list:
        for i in range(elem[0], elem[2]+1):
            for j in range(elem[1], elem[3]+1):
                array[i][j] = '#'

    for x in range(max_y+1):
        for y in range(max_x+1):
            print(array[y][x], end='')
        print("")
main()