$ErrorActionPreference = 'Stop'

python -m pip install --upgrade pip
python -m pip install requests pyyaml

python -m pip show requests
Write-Host "Environment ready"
