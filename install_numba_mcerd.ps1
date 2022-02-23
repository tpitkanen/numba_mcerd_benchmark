Import-Module (Join-Path -Path $PSScriptRoot -ChildPath .\utils.psm1)

Push-Location

Set-Location "c:\kurssit\gradu\koodi\"
if (-not (Test-Path -Path ".\numba_mcerd\.git")) {
    git clone git@github.com:tpitkanen/numba_mcerd.git
}

Set-Location numba_mcerd
$env:PYTHONPATH = (Get-Location).Path

if (-not (Test-Path -Path ".\env")) {
    py -3.8 -m venv env
    .\env\Scripts\activate
    pip install -r requirements.txt
} else {
    .\env\Scripts\activate
}

# Warm-up once to make sure the Virtualenv's Python and modules are compiled
python main_jit_mt.py
Remove-Pycache

Pop-Location
