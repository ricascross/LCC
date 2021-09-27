import sys


def anagrama(word):
    if word == '':
        return [word]
    else:
        resp = []
        for perm in anagrama(word[1:]):
            for pos in range(len(perm)+1):
                resp.append(perm[:pos]+word[0]+perm[pos:])
        #print(resp)
        return resp

   
            
def main():
    word = sys.stdin.readline().strip('\n')
    #word = ''.join(sorted(word))
    result = anagrama(word)
    result.sort()
    for word in result:
        print (word)
main()
