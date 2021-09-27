import sys
#import numpy as np
#recursve mode
'''
def knapsack(list_values,list_weight,limit_weight,n):
    
    if n == 0 or limit_weight == 0:
        return 0
    if (list_weight[n-1] > limit_weight):
        return knapsack(list_values, list_weight, limit_weight, n-1)
    else:
        return max(list_values[n-1]+knapsack(list_values,list_weight,limit_weight-list_weight[n-1],n-1 ),
                    knapsack(list_values,list_weight, limit_weight,n-1))
'''
     


#dynamic mode
def knapsack(list_values,list_weight,limit_weight,n):
    matrix = [[0 for x in range(limit_weight+1)] for y in range (n+1)]
    
    for i in range(n+1):
        for j in range(limit_weight+1):
            if i == 0 or j == 0:
                matrix[i][j] = 0
            elif list_weight[i-1]<= j:
                matrix[i][j] = max(list_values[i-1] + matrix[i-1][j-list_weight[i-1]], matrix[i-1][j])
            #print(matrix[i][j])
            else:
                matrix[i][j] = matrix[i-1][j]
    
    return matrix[n][limit_weight], matrix

def discover_items(matrix,n, limit_weight,list_weight,list_values, list_names, picked):
    for i in range(n,0,-1):
        #print(i)
        if matrix[i][limit_weight] != matrix[i-1][limit_weight]:
            #print(limit_weight)
            #print(matrix[i][limit_weight], matrix[i-1][limit_weight])
            index = list_values.index(matrix[i][limit_weight]-matrix[i-1][limit_weight])
            #print(index)
            picked.append(list_names[index])
            #print(picked)
            discover_items(matrix, i-1, limit_weight-list_weight[index], list_weight,list_values,list_names, picked)
            return picked

    

def main():
    
    txt = sys.stdin.readlines()
    limit_weight = int(txt[0])
    list_names = []
    list_values = []
    list_weight = []
    picked = []
    
    for lines in txt[1:]:
        lines = lines.split()
        list_weight.append(int(lines[2]))
        list_values.append(int(lines[1]))
        list_names.append(lines[0])
        #print(limit_weight, list_names, list_values, list_weight)
    
    result, matrix= knapsack(list_values,list_weight, limit_weight, len(list_values))
    print(result)
    
    
main()