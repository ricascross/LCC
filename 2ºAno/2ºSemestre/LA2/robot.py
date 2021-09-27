# encoding: utf-8
# encoding: iso-8859-1
# encoding: win-1252


import sys


def read_input():
    sequence_list = []
    for line in sys.stdin:
        sequence_list.append(line.splitlines()) # Splitlines remove os '\n'
    print(sequence_list)
    return sequence_list

def finalize(final_x, final_y, position_list):
    
    # Criar listas individuais para as componentes dos pares de coordenadas
    x = []
    y = []

    for pair in position_list:
        x.append(pair[0])
        y.append(pair[1])
    
    # Coordenadas do rectangulo final.
    x_min = min(min(x), final_x)
    x_max = max(max(x), final_x)
    y_min = min(min(y), final_y)
    y_max = max(max(y), final_y)
    
    print("(" + str(x_min) + "," + str(y_min) + ") (" + str(x_max) + "," + str(y_max) +")")


def execute_sequence(sequence):

    # Aqui guarda-se todas as posiçoes que o robot toma, ate parar.
    posistion_list = []

    # O robot começa com direçao vertical positiva.
    movement_direction = (0, 1)

    # Começo é na origem.
    current_x = 0
    current_y = 0
    current_pos = (current_x, current_y)
    
    posistion_list.append(current_pos)

    for command in sequence:
        if command == 'A':
            current_x += movement_direction[0]
            current_y += movement_direction[1]      
            current_pos = (current_x, current_y)
        elif command == 'D':
            movement_direction = (movement_direction[1], -movement_direction[0])
        elif command == 'E':
            movement_direction = (-movement_direction[1], movement_direction[0])
        elif command == 'H':
            break

        # Atualizar a lista de posições   
        if current_pos not in posistion_list:
            posistion_list.append(current_pos)
    
    # Saímos do loop, fizemos tudo o que tínhamos a fazer.
    return (current_x, current_y, posistion_list)
        
def main():
    read_list = read_input()

    for seq in read_list:
        sequence_result = execute_sequence(seq[0])

        finalize(sequence_result[0], sequence_result[1], sequence_result[2])
    
main()
