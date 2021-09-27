import sys
import itertools

def main():
    line = sys.stdin.readline().strip('\n')
    size = len(line)
    #line = ''.join(sorted(line))
    result = list(itertools.permutations(line,size))
    result.sort()
    for i in result:
        print(''.join(i))
main()

