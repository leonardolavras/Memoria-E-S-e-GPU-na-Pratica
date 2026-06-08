import re
import sys
from pathlib import Path

seq_file = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("results/seqread.txt")
rand_file = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("results/randread.txt")

items = [
    ("Leitura sequencial - 1 MB", seq_file),
    ("Leitura aleatória - 4 KB", rand_file),
]

lines = [
    "| Cenário | Bandwidth | IOPS |",
    "|---|---:|---:|",
]

for name, file in items:
    text = file.read_text(errors="ignore")
    bw = re.search(r"READ:.*?bw=([^,\s]+)", text, re.I | re.S)
    iops = re.search(r"read:.*?IOPS=([^,\s]+)", text, re.I | re.S)
    bw_value = bw.group(1) if bw else "-"
    iops_value = iops.group(1) if iops else "-"
    lines.append(f"| {name} | {bw_value} | {iops_value} |")

output = "\n".join(lines)
print(output)
Path("results/tabela_fio.md").write_text(output, encoding="utf-8")
