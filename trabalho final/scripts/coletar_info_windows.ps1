$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path results | Out-Null

"CPU" | Out-File -Encoding utf8 results\info_maquina.txt
Get-CimInstance Win32_Processor |
  Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed, L2CacheSize, L3CacheSize |
  Format-List | Out-File -Encoding utf8 -Append results\info_maquina.txt

"DISCOS" | Out-File -Encoding utf8 -Append results\info_maquina.txt
Get-CimInstance Win32_DiskDrive |
  Select-Object Model, InterfaceType, MediaType, Size |
  Format-Table -AutoSize | Out-File -Encoding utf8 -Append results\info_maquina.txt

"GPU" | Out-File -Encoding utf8 -Append results\info_maquina.txt
Get-CimInstance Win32_VideoController |
  Select-Object Name, AdapterRAM, DriverVersion |
  Format-Table -AutoSize | Out-File -Encoding utf8 -Append results\info_maquina.txt

Write-Host "results\info_maquina.txt"
