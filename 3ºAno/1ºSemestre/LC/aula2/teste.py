from z3 import *
def verifica_inteiro(n):
    # z3 solver

    s = Solver()

    aloc = {}
    for pombo in range(n):                # cria as variáveis z3
        aloc[pombo] = Int(str(pombo))
        s.add(0 <= aloc[pombo], aloc[pombo] < n-1)  # poleiro válido

    for pombo in aloc:
        for pombo2 in aloc:
            if pombo != pombo2:
                s.add(aloc[pombo] != aloc[pombo2])

    if s.check() == sat:
        m = s.model()
        print(m)
        return True
    else:
        return False


for n in range(2, 10):
    z = verifica_inteiro(n)
    print(z)
