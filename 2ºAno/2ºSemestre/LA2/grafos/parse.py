import sys


def parse(adj):
    for l in sys.stdin:
        o,d = l.split()
        if o not in adj:
            adj[o] = []
        if d not in adj:
            adj[d] = []
        adj[o].append(d)
        adj[d].append(o)
        print(parse)

adj = {}

parse(adj)

