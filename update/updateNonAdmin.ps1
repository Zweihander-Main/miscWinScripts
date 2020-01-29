$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path upgradeNonAdmin.txt
echo 'Powershell Update-Script'
Update-Script
echo 'NPM Update'
npm install -g npm
npm update -g
npm update -g 
#echo 'Perl Gnc-Fq-Update'
#perl 'C:\Program Files (x86)\gnucash\bin\gnc-fq-update'
Stop-Transcript
pause