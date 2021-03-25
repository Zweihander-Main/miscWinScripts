@echo off

rem Disable WF profiles
netsh advfirewall set allprofiles state off

rem Disable WF services (does not worked on Windows 10 Redstone 4+)
sc config mpssvc start= disabled
sc config mpsdrv start= disabled
sc stop mpssvc
sc stop mpsdrv