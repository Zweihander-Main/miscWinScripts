Stop-Process -processname AutoHotkey
Start-Sleep -Seconds 5
&"clearbugnfile.ps1"
Start-Sleep -Seconds 1
Start-Process "MasterStartupHotkeys.ahk" 
Start-Process "Main.ahk" -WorkingDirectory "src"
