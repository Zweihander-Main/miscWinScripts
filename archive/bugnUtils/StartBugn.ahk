#KeyHistory 0

psScript := "clearbugnfile.ps1"
monitorScript := "MonitorSwitcher.exe"
threeScreens := "3 screens.xml"
fourScreens := "4 screens (3+1DL).xml"
restartExplorer := "restartexplorer.bat"
bugNMain := "Main.ahk"
bugNDir := "src"
Run, powershell.exe "%psScript%"
Run, "%monitorScript%" -load:"%threeScreens%", , Hide,
Sleep, 2000
Run, %A_AhkPath% "bugNMain",bugNDir, ,
Sleep, 2000
Run, "%monitorScript%" -load:"%threeScreens%", , Hide,
Sleep, 5000
Run, %comspec% /c %restartExplorer%, c:\
Sleep, 6000
Run, %comspec% /c %restartExplorer%, c:\
Sleep, 2000
WinWait, ahk_class #32770, ,10, , 
WinActivate, ahk_class #32770, , , 
Send, {Left}{Enter}
Sleep, 2000
Run, "%restartExplorer%" -load:"%fourScreens%", , Hide,
Sleep, 1000
Run, %comspec% /c %restartExplorer%, c:\
WinWait, ahk_class #32770, ,10, , 
WinActivate, ahk_class #32770, , , 
Send, {Left}{Enter}
Sleep, 1000
Run, %comspec% /c %restartExplorer%, c:\
ExitApp
