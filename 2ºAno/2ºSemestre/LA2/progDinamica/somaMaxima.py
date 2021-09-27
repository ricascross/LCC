import sys
#from sys import maxsize
'''
def max_subsequence_sum(numbers, size):
    max_so_far = -maxsize-1
    max_ending_here = 0

    for i in range(size):
        max_ending_here = max_ending_here + numbers[i]
        if max_so_far < max_ending_here:
            max_so_far = max_ending_here
        if max_ending_here < 0:
            max_ending_here = 0
    return max_so_far
'''
#dynamic programming
def max_subsequence_sum(numbers, size):
    max_so_far =numbers[0] 
    curr_max = numbers[0] 
      
    for i in range(1,size): 
        curr_max = max(numbers[i], curr_max + numbers[i]) 
        max_so_far = max(max_so_far,curr_max) 
          
    return max_so_far 

def main():
    numbers = sys.stdin.readline().strip('\n').split()
    numbers = list(map(int,numbers))

    result = max_subsequence_sum(numbers, len(numbers))
    print(result)
    
main()