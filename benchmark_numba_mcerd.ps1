Import-Module (Join-Path -Path $PSScriptRoot -ChildPath .\utils.psm1)

function Measure-Jit {
    Write-Output "`nMeasure-Jit starting`n"

    Remove-Pycache
    python main_jit.py 2>&1 > out_jit_single_first.txt
    python main_jit.py 2>&1 > out_jit_single_second.txt
    python main_jit.py 2>&1 > out_jit_single_third.txt
    Remove-Pycache

    Write-Output "`nMeasure-Jit done`n"
}

function Measure-MultithreadJit {
    Write-Output "`nMeasure-MultithreadJit starting`n"

    Remove-Pycache
    python main_jit_mt.py 2>&1 > out_jit_mt_first.txt
    python main_jit_mt.py 2>&1 > out_jit_mt_second.txt
    python main_jit_mt.py 2>&1 > out_jit_mt_third.txt
    Remove-Pycache

    Write-Output "`nMeasure-MultithreadJit done`n"
}

function Measure-Vanilla {
    Write-Output "`nMeasure-Vanilla starting`n"

    $settingsFile = '..\data\input\O-Default'
    $originalSettings = Get-Content -Path $settingsFile

    $newSettings = $originalSettings -replace 'Number of ions:.*', 'Number of ions: 100000'
    $newSettings = $newSettings -replace 'Number of ions in the presimulation:.*', 'Number of ions in the presimulation: 10000'

    Remove-Pycache
    try {
        Set-Content -Path $settingsFile -Value $newSettings
        python main.py 2>&1 > out_vanilla_first.txt
        python main.py 2>&1 > out_vanilla_second.txt
    }
    finally {
        Set-Content -Path $settingsFile -Value $originalSettings
    }
    Remove-Pycache

    Write-Output "`nMeasure-Vanilla done`n"
}

function Invoke-Measurements {
    Push-Location

    Set-Location 'c:\kurssit\gradu\koodi\numba_mcerd\'
    .\env\Scripts\activate

    $env:PYTHONPATH = (Get-Location).Path
    Set-Location numba_mcerd

    Measure-Jit
    Measure-MultithreadJit
    Measure-Vanilla

    Pop-Location
}

Invoke-Measurements
