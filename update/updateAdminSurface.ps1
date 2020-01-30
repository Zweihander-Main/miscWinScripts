$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path updateAdminSurface.txt
echo 'Chocolatey'
choco upgrade all -y
Stop-Transcript