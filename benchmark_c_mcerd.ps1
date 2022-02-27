# Could probably be a parameter but this way is simpler
$startTime = $null

filter timestamp {
    # Absolute timestamp
    # "$(Get-Date -Format o): $_"

    # Relative timestamp
    $elapsed = ((Get-Date) - $global:startTime).TotalSeconds -f '0.0'
    "${elapsed}: $_"
}

function Invoke-CMeasurements {
    Push-Location

    try {
        Set-Location 'C:\kurssit\potku_2021\potku_2020\master\potku\external\bin'

        $global:startTime = Get-Date
        .\mcerd 'C:\kurssit\gradu\data\2020-11-27\mc_input\run\Cl-Default' 2>&1 | timestamp

        # Only reports total time:
        # Measure-Command { .\mcerd 'C:\kurssit\gradu\data\2020-11-27\mc_input\run\Cl-Default' 2>&1 | Out-Host }
    }
    finally {
        Pop-Location
    }
}
Invoke-CMeasurements
