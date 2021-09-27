def knapsack(W, items):
    """
    Given a list of items with name, value and weight.
    Return the optimal value with total weight <= allowed weight and 
    list of picked items.
    """ 
    n = len(items)
    k = [[0 for x in range(W+1)] for x in range(n+1)]

    for i in range(n+1):
        for w in range(W+1):
            if i == 0 or w == 0:
                k[i][w] = 0
            elif items[i-1][2] <= w:
                k[i][w] = max(items[i-1][1] + k[i-1][w-items[i-1][2]], k[i-1][w])
            else:
                k[i][w] = k[i-1][w]

    picked = []
    set_trace(k, n, W, items, picked)
    return k[n][W], picked

# find which item are picked
def set_trace(k, n, W, items, picked):
    for i in range(n, 0, -1):
        if k[i][W] != k[i-1][W]:
            picked.append(items[i-1])
            set_trace(k, i-1, W-items[i-1][2], items, picked)
            break

if __name__ == '__main__':
    items = [('biblia', 20, 2), ('microondas', 150, 10), ('televisao', 200, 15), ('torradeira', 40, 3)]
    max_value,  picked = knapsack(18, items)
    print("Maximum value:", max_value)
    print("Name", "Value", "Weight")
    for item in reversed(picked):
        print(item[0], ' '*2, item[1], ' '*3, item[2])