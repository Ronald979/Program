$ErrorActionPreference = 'Stop'

Write-Host "[1/6] PowerShell: $(Get-Host | Select-Object -ExpandProperty Version)"
Write-Host "[2/6] Python: $(python --version)"
Write-Host "[3/6] Docker: $(docker --version)"
Write-Host "[4/6] Docker compose: $(docker compose version)"
Write-Host "[5/6] GPU check:"
try { & nvidia-smi | Select-Object -First 8 } catch { Write-Warning 'nvidia-smi not available'; }

if (Get-Command python -ErrorAction SilentlyContinue) {
  python -m pip show requests | Out-Null
  Write-Host "requests OK"
}
Write-Host "[6/6] HTTP endpoint test:"
try {
  $r = Invoke-WebRequest -Uri 'http://localhost:11434' -Method Get -TimeoutSec 5 -UseBasicParsing
  Write-Host "ollama endpoint reachable: $($r.StatusCode)"
} catch {
  Write-Warning "ollama endpoint not ready: $_"
}
