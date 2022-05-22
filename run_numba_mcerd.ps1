function Invoke-NumbaMcerd {
    Push-Location

    try {
        Set-Location 'c:\kurssit\gradu\koodi\numba_mcerd\'
        .\env\Scripts\activate
    
        $env:PYTHONPATH = (Get-Location).Path
        Set-Location numba_mcerd
    
        python main_jit.py
    }
    finally {
        Pop-Location
    }
}

Invoke-NumbaMcerd
