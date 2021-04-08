Get-Content bug.n\data\_WindowState.ini | Select-String -pattern ";;;;;;" -notmatch | Out-File bug.n\data\_WindowState.ini
