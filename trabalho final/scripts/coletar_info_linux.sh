#!/usr/bin/env bash
set -e

mkdir -p results
{
  echo "CPU"
  lscpu
  echo
  echo "DISCOS"
  lsblk -o NAME,MODEL,SIZE,TYPE,MOUNTPOINT
  echo
  echo "GPU"
  lspci | grep -Ei "vga|3d|display" || true
} > results/info_maquina.txt

echo "results/info_maquina.txt"
