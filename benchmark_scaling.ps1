Import-Module (Join-Path -Path $PSScriptRoot -ChildPath .\utils.psm1)

function Measure-Cores {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$CoreCount
    )

    Write-Output "`nMeasure-Cores ($CoreCount) starting`n"

    $configFile = '.\config.py'
    $originalConfig = Get-Content -Path $configFile
    $newSettings = $originalConfig -replace 'PARALLEL_THREAD_COUNT =.*', "PARALLEL_THREAD_COUNT = ${CoreCount}"

    Remove-Pycache
    try {
        Set-Content -Path $configFile -Value $newSettings
        python main_jit_mt.py 2>&1 > "out_jit_mt_${CoreCount}_first.txt"
        python main_jit_mt.py 2>&1 > "out_jit_mt_${CoreCount}_second.txt"
        python main_jit_mt.py 2>&1 > "out_jit_mt_${CoreCount}_third.txt"
    }
    finally {
        Set-Content -Path $configFile -Value $originalConfig
    }
    Remove-Pycache

    Write-Output "`nMeasure-Cores (${CoreCount}) done`n"
}

function Invoke-Measurements {
    Push-Location

    Set-Location 'c:\kurssit\gradu\koodi\numba_mcerd\'
    .\env\Scripts\activate

    $env:PYTHONPATH = (Get-Location).Path
    Set-Location numba_mcerd

    # Measure-Cores -CoreCount 1
    Measure-Cores -CoreCount 2
    Measure-Cores -CoreCount 3
    Measure-Cores -CoreCount 4
    Measure-Cores -CoreCount 6
    Measure-Cores -CoreCount 8
    Measure-Cores -CoreCount 10
    Measure-Cores -CoreCount 12
    Measure-Cores -CoreCount 14
    Measure-Cores -CoreCount 16
    Measure-Cores -CoreCount 18
    # Measure-Cores -CoreCount 20

    Pop-Location
}
Invoke-Measurements
