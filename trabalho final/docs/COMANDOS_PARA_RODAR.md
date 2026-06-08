# Comandos para rodar

## Linux / WSL

```bash
gcc -O2 -o cachebench src/cache/cachebench.c
./cachebench > results/resultado_cache.csv
python scripts/plot_cache.py results/resultado_cache.csv results/grafico_cache.png

bash src/storage/run_fio.sh
python scripts/parse_fio.py results/seqread.txt results/randread.txt

bash scripts/coletar_info_linux.sh
```

## Windows

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\coletar_info_windows.ps1
.\src\storage\benchmark_disco_windows.ps1
```

Para a atividade 3, abrir:

```text
src/webgpu/matrix_webgpu.html
```
