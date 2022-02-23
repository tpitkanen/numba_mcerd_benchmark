function Remove-Pycache {
    # TODO: Find folders with
    # Get-ChildItem -Path <path> -Recurse -Filter __pycache__ | Remove-Item -Force

    <#
    .SYNOPSIS
    Clear __pycache__ folders in current location
    #>
    if (Test-Path -Path __pycache__) {
        Remove-Item -Recurse -Force -Path __pycache__
    }

    if (Test-Path -Path mcerd\__pycache__) {
        Remove-Item -Recurse -Force -Path mcerd\__pycache__
    }
}
