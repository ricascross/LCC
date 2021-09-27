import sys
import itertools


def parse_input():
    lines = sys.stdin.readlines()

    sets = []
    for line in lines:
        sets.append(set(map(int, line.split(' '))))
    
    universo = sets[0]

    for conj in sets:
        universo = universo.union(conj)

    return universo, sets


def solucao_ok(univ, conjs):
    """ testa se uniao de 'conjs' é 'univ' """
    u = set([])
    for i in conjs:
        u = u.union(i)
    return u==univ


def k_x(k, conjs, univ):
    """ testa se existe uma k-cobertura (i.e. se a união de 'k' 
       elementos é 'uinv' """
    for s in itertools.combinations(conjs, k):
        if solucao_ok(univ, s): return True
    return False


def x(conjs):
    """ retorna menor num. de elementos de conj. que formam cobertura do universo """
    univ = set([])

    for con in conjs:
        univ = univ.union(con)

    for i in range(len(conjs)):
        if k_x(i, conjs, univ): return i

    return len(conjs)


def main():
    universo, conjuntos = parse_input()
    return x(conjuntos)


if __name__ == "__main__":
    print(main())
