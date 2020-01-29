$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path updateAdmin.txt
echo 'PowerShell Update-Script'
Update-Script
echo 'PowerShell Update-Module'
Update-Module
echo 'Chocolatey'
choco upgrade all -y
#echo 'Pip-review (3)'
#pip-review --auto
echo 'NPM Update'
npm install -g npm
npm update -g
npm update -g
echo 'Gem Update System'
gem update --system
#echo 'Gem Update'
#gem update
Stop-Transcript
pause