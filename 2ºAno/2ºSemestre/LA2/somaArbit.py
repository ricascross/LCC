import sys

def main():
    txt = sys.stdin.readlines()
    result = 0
    for l in txt:
        result += int(l)
    print(result)
    


main()