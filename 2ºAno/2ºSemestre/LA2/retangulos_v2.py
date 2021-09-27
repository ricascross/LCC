import sys

def main():

    rectangles = []
    for line in sys.stdin:
        line = line.strip('\n').split()
        line = list(map(int,line))
        rectangles.append(list(line))
    output_list = []

    for rect in rectangles:
        x1, y1, x2, y2 = [int(coord) for coord in rect]
        for i in range(y1, y2 + 1):
            prev = output_list[i] if i < len(output_list) else ''
            if len(prev) < x2:
                prev += ' ' * (x2 - len(prev) + 1)
            prev = prev[:x1] + '#' * (x2 - x1 + 1) + prev[x2 + 1:]
            if i < len(output_list):
                output_list[i] = prev
            else:
                output_list.append(prev)

    output = '\n'.join(output_list)
    print(output)
main()