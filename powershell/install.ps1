# Hostname
$hn = hostname
write-output "hostname is: $hn"

# Install and activate SSH server
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'



# Open firewall for SSH
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 -Profile Any
} else {
    Remove-NetFirewallRule -Name "OpenSSH-Server-In-TCP"
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP'  exists and is being reset."
}

# Open firewall for ping
if (!(Get-NetFirewallRule -Name "ICMPv4" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    New-NetFirewallRule -Name 'ICMPv4' -DisplayName 'ICMPv4' -Enabled True -Direction Inbound -Action Allow -Profile Any
    Write-Output "Creating ICMPv4 fw rule"
} else {
    Write-Output "FW rule ICMPv4 already exists"
}



# Install choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
# Set DNS
Get-NetAdapter
$ifi = Read-Host "vilken index?"
Set-DnsClientServerAddress -InterfaceIndex $ifi -ServerAddresses ("192.168.20.157","8.8.8.8")


function cppp {
	# TODO: Fix params that points to the right drive
$source      = "D:\Kagg_Filer"
$destination = "C:\Kagg_Filer"

# Get all files (recursively)
$files = Get-ChildItem -Path $source -Recurse -File
$total = $files.Count
$count = 0
foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($source.Length)
    $targetPath   = Join-Path $destination $relativePath

    # Create target directory if it doesn't exist
    $targetDir = Split-Path $targetPath
    if (-not (Test-Path $targetDir)) {
        New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
    }

    # Copy the file
    Copy-Item -Path $file.FullName -Destination $targetPath 

    $count++
    $percent = ($count / $total) * 100

    Write-Progress -Activity "Copying files..." `
                   -Status "Copying $($file.Name) ($count of $total)" `
                   -PercentComplete $percent
}

Write-Progress -Activity "Copying files..." -Completed -Status "Done!"
}
# Copy files
cppp
