#KeyHistory 0
DetectHiddenWindows, On
WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	r := wt . "`n"
	If (InStr(r,"Anki")) {
		WinShow, ahk_id %id%
	}
}
ExitApp
