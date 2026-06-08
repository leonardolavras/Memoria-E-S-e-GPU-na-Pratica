$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path results | Out-Null

$file = "results\testfile.bin"
$size = 1GB
$seqBufferSize = 1MB
$randBufferSize = 4KB
$seconds = 20

$fs = [System.IO.File]::Open($file, [System.IO.FileMode]::Create, [System.IO.FileAccess]::ReadWrite)
$fs.SetLength($size)
$fs.Close()

$buffer = New-Object byte[] $seqBufferSize
$stream = [System.IO.File]::OpenRead($file)
$timer = [System.Diagnostics.Stopwatch]::StartNew()
$totalBytes = 0L
$ops = 0L

while ($timer.Elapsed.TotalSeconds -lt $seconds) {
    $read = $stream.Read($buffer, 0, $buffer.Length)
    if ($read -eq 0) {
        $stream.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null
        continue
    }
    $totalBytes += $read
    $ops++
}

$timer.Stop()
$stream.Close()
$seqMBs = ($totalBytes / 1MB) / $timer.Elapsed.TotalSeconds
$seqIOPS = $ops / $timer.Elapsed.TotalSeconds

$buffer = New-Object byte[] $randBufferSize
$stream = [System.IO.File]::OpenRead($file)
$random = New-Object System.Random
$maxBlocks = [int]($size / $randBufferSize)
$timer = [System.Diagnostics.Stopwatch]::StartNew()
$totalBytes = 0L
$ops = 0L

while ($timer.Elapsed.TotalSeconds -lt $seconds) {
    $block = $random.Next(0, $maxBlocks)
    $offset = [int64]$block * [int64]$randBufferSize
    $stream.Seek($offset, [System.IO.SeekOrigin]::Begin) | Out-Null
    $read = $stream.Read($buffer, 0, $buffer.Length)
    $totalBytes += $read
    $ops++
}

$timer.Stop()
$stream.Close()
$randMBs = ($totalBytes / 1MB) / $timer.Elapsed.TotalSeconds
$randIOPS = $ops / $timer.Elapsed.TotalSeconds

$tabela = @"
| Cenário | Bandwidth aproximado | IOPS aproximado |
|---|---:|---:|
| Leitura sequencial - 1 MB | $([Math]::Round($seqMBs, 2)) MB/s | $([Math]::Round($seqIOPS, 2)) |
| Leitura aleatória - 4 KB | $([Math]::Round($randMBs, 2)) MB/s | $([Math]::Round($randIOPS, 2)) |
"@

$tabela | Out-File -Encoding utf8 results\tabela_disco_windows.md
$tabela
