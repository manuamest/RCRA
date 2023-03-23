import sys
import re

def parse_solution(solution):
    hlines = []
    vlines = []

    segments = re.findall(r'\((\d+,\d+)\),\((\d+,\d+)\)', solution)

    for segment in segments:
        start = tuple(map(int, segment[0].split(',')))
        end = tuple(map(int, segment[1].split(',')))

        if start[0] == end[0]:  # La coordenada x es la misma, es una línea vertical
            vlines.append(tuple(sorted((start[1], end[1]))))
            vlines.append((start[0], min(start[1], end[1])))
        else:  # La coordenada y es la misma, es una línea horizontal
            hlines.append(tuple(sorted((start[0], end[0]))))
            hlines.append((min(start[0], end[0]), start[1]))

    return hlines, vlines

def print_solution(hlines, vlines, size):
    for i in range(2 * size + 1):
        row = ""
        for j in range(2 * size + 1):
            if i % 2 == 0 and j % 2 == 0:
                row += "+"
            elif i % 2 == 1 and j % 2 == 0 and (i // 2, j // 2) in vlines:
                row += "|"
            elif i % 2 == 0 and j % 2 == 1 and (i // 2, j // 2) in hlines:
                row += "--"
            elif i % 2 == 1 and j % 2 == 0:
                row += " "
            else:
                row += "  "
        print(row)

def main(solution):
    hlines, vlines = parse_solution(solution)

    if not hlines and not vlines:
        print("No solution found.")
        return

    size = max(max(x for x, _ in hlines + vlines), max(y for _, y in hlines + vlines)) + 1
    print_solution(hlines, vlines, size)

if __name__ == "__main__":
    solution = sys.stdin.read()
    main(solution)
