#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On

switch := A_Args[1]
;Avoid starting and stopping on Sat
if (switch = "start") ;Task scheduler at given time
{
	StartAnnoying()
} 

StartAnnoying()
{
	i := 0
	SysGet, VirtualWidth, 78
	SysGet, VirtualHeight, 79
	Loop
	{
		IniRead, switchEngaged, switchSetting.ini, switchSection, switchStatus
		if (switchEngaged == "false") {
			Random, RHertz , 1500, 8000
			Random, RLength , 200, 900
			Random, RPause , 300, 500
			FormatTime, currentHour,,H
			FormatTime, currentMinutes,,mm
			intensityCalc := ((currentHour + (currentMinutes/60)) - 0.16)*500 ;12:10 start
			SoundBeep, RHertz, RLength  + intensityCalc
			
			if (i == 20) {
				Loop, 5 {
					SoundBeep, 2000, 100
				}
				Send #{Home}
				Send {Lwin up}
			}
			if (i == 21) {
				Send #{Home}
				Send {Lwin up}
				i := 0
			}
			
			SplashImage,,B w%A_ScreenWidth% h%A_ScreenHeight% cwBlack
			Sleep, 75 + intensityCalc
			SplashImage,off
			
			Sleep, 925 - RLength + RPause
			
			i++
			continue
		} else {
			break
		}
	}
}