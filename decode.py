# Jose Manuel Amestoy Lopez     manuel.amestoy@udc.es
# Juan Villaverde Rodriguez     juan.villaverde.rodriguez@udc.es

import sys
import re

def parse_solution(solution):
    hlines = set()
    vlines = set()

    segments = re.findall(r'\((\d+,\d+)\),\((\d+,\d+)\)', solution)

    for segment in segments:
        start = tuple(map(int, segment[0].split(',')))
        end = tuple(map(int, segment[1].split(',')))

        if start[0] == end[0]:  # La coordenada x es la misma, es una línea horizontal
            hlines.add((start[0], min(start[1], end[1])))
        else:  # La coordenada y es la misma, es una línea vertical
            vlines.add((min(start[0], end[0]), start[1]))

    # Agregamos los segmentos invertidos
    for segment in segments:
        start = tuple(map(int, segment[1].split(',')))
        end = tuple(map(int, segment[0].split(',')))

        if start[0] == end[0]:  # La coordenada x es la misma, es una línea horizontal
            hlines.add((start[0], min(start[1], end[1])))
        else:  # La coordenada y es la misma, es una línea vertical
            vlines.add((min(start[0], end[0]), start[1]))

    return hlines, vlines


def print_solution(hlines, vlines, size):
    for i in range(2 * size - 1):
        row = ""
        for j in range(2 * size - 1):
            if i % 2 == 0 and j % 2 == 0:
                row += "+"
            elif i % 2 == 1 and j % 2 == 0 and (i // 2,j // 2) in vlines:
                row += "|"
            elif i % 2 == 0 and j % 2 == 1 and (i // 2,j // 2) in hlines:
                row += "--"
            elif i % 2 == 1 and j % 2 == 0:
                row += " "
            else:
                row += "  "
        print(row)

def extract_size(solution):
    match = re.search(r'size\((\d+)\)', solution)
    if match:
        return int(match.group(1))
    else:
        raise ValueError("Size not found in the solution.")

def main(solution):
    size = extract_size(solution)
    hlines, vlines = parse_solution(solution)

    if not hlines and not vlines:
        print("No solution found.")
        return

    print_solution(hlines, vlines, size)

if __name__ == "__main__":
    solution = sys.stdin.read()
    main(solution)
