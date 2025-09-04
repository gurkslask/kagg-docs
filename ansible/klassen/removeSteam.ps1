# Sökvägen till mappen C:\Användare
$usersPath = "C:\Users"

# Fånga alla användarmappar, exkludera Public och default-mappar
$userFolders = Get-ChildItem -Path $usersPath -Directory | Where-Object { $_.Name -ne "Public" -and $_.Name -ne "Default" -and $_.Name -ne "Default User" }

# Loopa igenom varje användarmapp
foreach ($user in $userFolders) {
    # Skapa sökvägen till användarens Hämtade filer-mapp
    $downloadsPath = Join-Path -Path $user.FullName -ChildPath "Downloads"

    # Kontrollera om Hämtade filer-mappen existerar
    if (Test-Path -Path $downloadsPath) {
        # Sök efter filen 'SteamSetup.exe' i Hämtade filer-mappen
        $file = Get-ChildItem -Path $downloadsPath -Filter "SteamSetup.exe" -File -ErrorAction SilentlyContinue

        # Kontrollera om filen hittades
        if ($file) {
            Write-Host "Filen 'SteamSetup.exe' hittades för användaren '$($user.Name)'."
            Write-Host "Fullständig sökväg: $($file.FullName)"
            Write-Host "Senast ändrad: $($file.LastWriteTime)"
            Write-Host "Storlek: $($file.Length / 1MB) MB"
            Write-Host "--------------------------------------------------"
			Remove-Item $file.FullName
        }
    }
}
