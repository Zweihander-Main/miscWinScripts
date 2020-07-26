#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#KeyHistory 0
#MaxThreadsPerHotkey 3
#MenuMaskKey vkE8

; Utility

; Disable win key opening start menu
; LWin & vk07::return
; LWin::return

; Hotkeys

HelpArray := []
HelpArray.push("Win+L: Lock system, monitor off")
HelpArray.push("Win+Shift+E: Restart explorer.exe")
HelpArray.push("Win+Ctrl+3: Toggle monitor configurations-3 Screens.xml")
HelpArray.push("Win+Ctrl+4: Toggle monitor configurations-4 Screen (3+1DL).xml")
HelpArray.push("Alt+Shift+Ctrl+F1: Get class of current window")
HelpArray.push("Alt+F1: Create Cmder terminal unless exists already")
HelpArray.push("Alt+Shift+F1: Create Cmder terminal no matter what")
HelpArray.push("Alt+F5: Auto-clicker")
HelpArray.push("Alt+F6: Record keystrokes")+
HelpArray.push("Alt+F7: Playback recorded keystrokes")
HelpArray.push("Alt+F8: Playback clipboard top entry slowly")
HelpArray.push("Alt+F9: Playback clipboard top entry quickly")
HelpArray.push("Alt+Ctrl+u: Hotkey Alias For Cmder/cd ..")
HelpArray.push("Win+T Remove title bar from active window")
HelpArray.push("Win+Shift+?: Help Popup")
HelpArray.push("Win+I Debug window under mouse cursor info")


#L:: ;Win+L: Lock system, monitor off
{
	KeyWait LWin
	KeyWait RWin
	Sleep, 200
	DllCall("LockWorkStation") ; Lock PC
	Sleep, 200
	SendMessage,0x112,0xF170,2,,Program Manager ; Monitor off
}
return

#+e:: ;Win+Shift+E: Restart explorer.exe
{
	Run %comspec% /c taskkill /f /IM explorer.exe, hide
	Sleep, 1000
	Run explorer.exe, hide
}
return

#+^3:: ;Win+Ctrl+3: Toggle monitor configurations-3 Screens.xml
{
	Run, MonitorSwitcher.exe -load:"%APPDATA%\MonitorSwitcher\Profiles\3 Screens.xml", , Hide,
}
return

#+^4:: ;Win+Ctrl+4: Toggle monitor configurations-4 Screen (3+1DL).xml
{
	Run, MonitorSwitcher.exe -load:"%APPDATA%\MonitorSwitcher\Profiles\4 Screen (3+1DL).xml", , Hide,
}
return


!+^F1:: ;Alt+Shift+Ctrl+F1: Get class of current window
{
	WinGetClass, theClassOfTheWindow, A
	MsgBox, The active window's class is "%theClassOfTheWindow%"
}
return

!F1:: ;Alt+F1: Create Cmder terminal unless exists already
{
	DetectHiddenWindows, on
	IfWinExist ahk_class VirtualConsoleClass
	{
		IfWinActive ahk_class VirtualConsoleClass
		{
			WinHide ahk_class VirtualConsoleClass
			WinActivate ahk_class Shell_TrayWnd
		}
		else
		{
			WinShow ahk_class VirtualConsoleClass
			WinActivate ahk_class VirtualConsoleClass
		}
	}
	else
	{
		Run "C:\dev\utils\cmder\Cmder.exe Shortcut.lnk"
	}
	DetectHiddenWindows, off
}
return

!+F1:: ;Alt+Shift+F1: Create Cmder terminal no matter what
{
	Run "C:\dev\utils\cmder\Cmder.exe Shortcut.lnk"
}
return

!F5:: ;Alt+F5: Auto-clicker
{
	Toggle := !Toggle
	Loop
	{
		If (!Toggle)
			Break
		Click
		Sleep 10 ; Make this number higher for slower clicks, lower for faster.
	}
}
return


!F6:: ;Alt+F6: Record keystrokes
{
	Input, keystrokes, V C , {esc}
}
return


!F7:: ;Alt+F7: Playback recorded keystrokes
{
	Send, %keystrokes%
}
return


!F8:: ;Alt+F8: Playback clipboard top entry slowly
{
	Loop, Parse, clipboard
	{
	   Send, {Raw}%A_LoopField%
	   Sleep 150
	}
}
return


!F9:: ;Alt+F9: Playback clipboard top entry quickly
Loop, Parse, clipboard
{
   Send, {Raw}%A_LoopField%
   Sleep 20
}
return

IfWinActive ahk_class VirtualConsoleClass
{
	!^u:: ;Alt+Ctrl+u: Hotkey Alias For Cmder/cd ..
	{
		Send cd ..{Enter}
	}
	return
}


#T:: ;Win+T Remove title bar from active window"
{
	WinSet, Style, -0xC00000, A
}
return

#?:: ;Win+Shift+?: Help Popup
{
	HelpString := ""
	for index, element in HelpArray
	{
		HelpString := HelpString . element . "`n"
	}
	MsgBox, %HelpString%
}
return

#I:: ;Win+I Debug window under mouse cursor info
{
	Debug_logWindowInfo(wndId) {
	  Local aWndId, detectHidden, text
	  Local isBugnActive, isResponsive, isWinFocus
	  Local wndClass, wndH, wndPId, wndPName, wndStyle, wndTitle, wndW, wndX, wndY

	  detectHidden := A_DetectHiddenWindows
	  DetectHiddenWindows, On
	  WinGet, aWndId, ID, A
	  If aWndId = %wndId%
		isWinFocus := "*"
	  Else
		isWinFocus := " "
	  WinGetTitle, wndTitle, ahk_id %wndId%
	  WinGetClass, wndClass, ahk_id %wndId%
	  WinGet, wndPName, ProcessName, ahk_id %wndId%
	  WinGet, wndPId, PID, ahk_id %wndId%
	  WinGet, wndStyle, Style, ahk_id %wndId%
	  WinGetPos, wndX, wndY, wndW, wndH, ahk_id %wndId%
	  DetectHiddenWindows, %detectHidden%

	  text := "ID: " wndId "`n"
	  text .= "Is Focused: " isWinFocus "`n"
	  text .= "X: " wndX "`nY: " wndY "`nW: " wndW "`nH: " wndH "`nStyle: " wndStyle "`nProcess Name: " wndPName " [" wndPId "]`nClass: " wndClass "`nTitle: " wndTitle
	  clipboard := text
	  MsgBox, %text%
	}
	MouseGetPos, , , id
	Debug_logWindowInfo(id)
}
