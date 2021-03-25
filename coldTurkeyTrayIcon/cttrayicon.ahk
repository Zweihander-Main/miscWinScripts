#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include TrayIcon.ahk
DetectHiddenWindows, On

switch := A_Args[1]

;Avoid starting and stopping on Sat
if (switch = "start" and CurrentDayOfWeek != 7) ;Task scheduler on logon
{
	StartBlockListSwitchCheck()
} 
else if (switch = "stop" and CurrentDayOfWeek != 7) ;From email alert
{
	EndBlockList()
} 
else if (switch = "disengage") ;Task scheduler at 5AM
{
	DisengageSwitch()
}

StartBlockListSwitchCheck()
{
	IniRead, switchEngaged, switchSetting.ini, switchSection, switchStatus
	if (switchEngaged = "false") {
		StartBlockList()
	}
}

EngageSwitch() 
{
	IniWrite, true, switchSetting.ini, switchSection, switchStatus
}

DisengageSwitch()
{
	IniWrite, false, switchSetting.ini, switchSection, switchStatus
}

StartBlockList()
{
	TrayIcon_Button("Cold Turkey Blocker.exe", "R")
	SendInput {S 1}
	SendInput {Up 1} ; Prod Killers
	SendInput {Right 1}
	SendInput {Up 1} ; 8 hours
	SendInput {Enter 1}
	EngageSwitch()
}

EndBlockList()
{
	Run, "C:\Program Files\Cold Turkey\Cold Turkey Blocker.exe"
	WinWaitActive, Cold Turkey Blocker
	Sleep, 500
	
	; 98,88 - client -- dashboard
	; 98,324 - client -- timers
	; 1707, 328 - client -- prod killers timer off
	
	CoordMode, Mouse, Client
	WinActivate, Cold Turkey Blocker
	Click, 98, 88
	Sleep, 350
	WinActivate, Cold Turkey Blocker
	Click, 98, 324
	Sleep, 350
	WinActivate, Cold Turkey Blocker
	Click, 1707, 328
	Sleep, 250
	WinClose, Cold Turkey Blocker
}
