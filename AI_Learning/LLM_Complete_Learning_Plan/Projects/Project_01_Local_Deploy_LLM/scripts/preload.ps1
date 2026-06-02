param(
  [string]$Model = "phi3:mini"
)

if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
  Write-Error "ollama CLI not found. Please install Ollama first."
  exit 1
}

Write-Host "Preloading model: $Model"
ollama pull $Model
Write-Host "Done"
