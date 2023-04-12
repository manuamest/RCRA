# Jose Manuel Amestoy Lopez     manuel.amestoy@udc.es
# Juan Villaverde Rodriguez     juan.villaverde.rodriguez@udc.es

import sys

def read_matrix(file):
    matrix = []
    with open(file, 'r') as f:
        for line in f:
            row = list(map(int, line.strip().split()))
            matrix.append(row)
    return matrix

def generate_lp(matrix, output_file):
    size = len(matrix[0]) # Calcula el tamaño basado en la cantidad de elementos de la primera fila
    with open(output_file, 'w') as f:
        f.write(f'size({size}).\n')
        for i in range(size):
            for j in range(size):
                if matrix[i][j] != 0:
                    f.write(f'number(({i},{j}), {matrix[i][j]}).\n')

def main(input_file, output_file):
    matrix = read_matrix(input_file)
    generate_lp(matrix, output_file)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 encode.py input_file output_file")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    main(input_file, output_file)
