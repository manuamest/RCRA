import sys

def parse_solution(solution):
    hlines = []
    vlines = []

    for line in solution.split("\n"):
        if "hline" in line:
            hlines.append(tuple(map(int, line[6:-2].split(","))))
        elif "vline" in line:
            vlines.append(tuple(map(int, line[6:-2].split(","))))

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
