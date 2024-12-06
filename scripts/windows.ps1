# Define the custom domain and the IP address
$customDomain = "myapp.local"
$localIp = "127.0.0.1"

# Check if the script is run as Administrator (needed for modifying the hosts file)
$admin = [System.Security.Principal.WindowsPrincipal][System.Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $admin.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as Administrator."
    exit 1
}

# Modify the hosts file (C:\Windows\System32\drivers\etc\hosts) to map custom domain to localhost
$hostsFile = "C:\Windows\System32\drivers\etc\hosts"
$entry = "$localIp $customDomain"

# Check if the entry already exists in the hosts file
if (-not (Select-String -Path $hostsFile -Pattern $customDomain)) {
    Write-Host "Adding $customDomain to hosts file..."
    Add-Content -Path $hostsFile -Value $entry
    Write-Host "Successfully added $customDomain to the hosts file."
} else {
    Write-Host "$customDomain is already in the hosts file."
}

# Start the Next.js development server
Write-Host "Starting Next.js development server..."
npm run dev