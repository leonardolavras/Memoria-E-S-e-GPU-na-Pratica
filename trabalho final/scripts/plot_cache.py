import csv
import sys
import matplotlib.pyplot as plt

input_file = sys.argv[1] if len(sys.argv) > 1 else "results/resultado_cache.csv"
output_file = sys.argv[2] if len(sys.argv) > 2 else "results/grafico_cache.png"

sizes = []
times = []

with open(input_file, newline="", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        sizes.append(float(row["size_kb"]))
        times.append(float(row["ns_per_access"]))

plt.figure(figsize=(9, 5))
plt.plot(sizes, times, marker="o")
plt.xscale("log", base=2)
plt.xlabel("Tamanho do array (KB)")
plt.ylabel("Tempo médio de acesso (ns)")
plt.title("Tempo de acesso conforme o tamanho do array")
plt.grid(True, which="both", linestyle="--", linewidth=0.5)
plt.tight_layout()
plt.savefig(output_file, dpi=200)

print(output_file)
