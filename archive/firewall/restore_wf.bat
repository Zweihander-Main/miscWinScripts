@echo off

rem Restore WF services
sc config mpsdrv start= auto
sc config mpssvc start= auto
sc start mpsdrv
sc start mpssvc

rem Restore WF profiles
netsh advfirewall set allprofiles state on