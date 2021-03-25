cd "C:\Program Files (x86)\gnucash\bin"
tasklist /nh /fi "imagename eq gnucash.exe" | find /i "gnucash.exe"
if errorlevel 0 if not errorlevel 1 goto IsRunning
gnucash --add-price-quotes ~\Documents\GnuCash\Personal.gnucash
:exit
exit

:IsRunning
exit
