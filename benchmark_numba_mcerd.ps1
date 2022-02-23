Import-Module (Join-Path -Path $PSScriptRoot -ChildPath .\utils.psm1)

function Measure-Jit {
    python main_jit.py > out_jit_first.txt
    python main_jit.py > out_jit_second.txt
    python main_jit.py > out_jit_third.txt
    Remove-Pycache
}

function Measure-MultithreadJit {
    python main_jit_mt.py > out_jit_mt_first.txt
    python main_jit_mt.py > out_jit_mt_second.txt
    python main_jit_mt.py > out_jit_mt_third.txt
    Remove-Pycache
}

# TODO
function Measure-Vanilla {
    # python main.py > out_vanilla_first.txt
    # python main.py > out_vanilla_second.txt
    # Remove-Pycache
}

function Invoke-Measurements {
    Push-Location

    Set-Location "c:\kurssit\gradu\koodi\numba_mcerd\"
    .\env\Scripts\activate

    $env:PYTHONPATH = (Get-Location).Path
    Set-Location numba_mcerd

    Measure-Jit
    Measure-MultithreadJit
    # Measure-Vanilla

    Pop-Location
}

Invoke-Measurements
