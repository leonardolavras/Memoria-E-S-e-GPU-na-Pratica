# Memória, E/S e GPU na prática

Repositório usado para as três atividades práticas da disciplina:

1. Hierarquia de memória/cache
2. E/S e armazenamento
3. CPU vs GPU usando WebGPU

Os resultados dos testes devem ser colocados na pasta `results/` e usados no relatório em `docs/`.

## Atividade 1 - cache

Compilar:

```bash
gcc -O2 -o cachebench src/cache/cachebench.c
```

Rodar:

```bash
./cachebench > results/resultado_cache.csv
```

Gerar gráfico:

```bash
python scripts/plot_cache.py results/resultado_cache.csv results/grafico_cache.png
```

## Atividade 2 - disco

Linux ou WSL:

```bash
bash src/storage/run_fio.sh
python scripts/parse_fio.py results/seqread.txt results/randread.txt
```

Windows PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\src\storage\benchmark_disco_windows.ps1
```

## Atividade 3 - WebGPU

Abrir o arquivo no navegador:

```text
src/webgpu/matrix_webgpu.html
```

Se o navegador bloquear o arquivo local, subir um servidor simples:

```bash
python -m http.server 8000
```

Depois acessar:

```text
http://localhost:8000/src/webgpu/matrix_webgpu.html
```

## Informações da máquina

Linux:

```bash
bash scripts/coletar_info_linux.sh
```

Windows:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\coletar_info_windows.ps1
```
