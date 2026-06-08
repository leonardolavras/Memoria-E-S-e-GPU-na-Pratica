#!/usr/bin/env bash
set -e

mkdir -p results
fallocate -l 1G results/testfile

fio --name=seqread \
  --filename=results/testfile \
  --rw=read \
  --bs=1M \
  --size=1G \
  --direct=1 \
  --runtime=20 \
  --time_based \
  --output=results/seqread.txt

fio --name=randread \
  --filename=results/testfile \
  --rw=randread \
  --bs=4k \
  --size=1G \
  --direct=1 \
  --runtime=20 \
  --time_based \
  --iodepth=32 \
  --output=results/randread.txt

echo "Arquivos gerados em results/"
