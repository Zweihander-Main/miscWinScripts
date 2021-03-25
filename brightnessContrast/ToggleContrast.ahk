#KeyHistory 0

;q:: ;toggle high contrast
vSize := A_PtrSize=8?16:12
VarSetCapacity(HIGHCONTRAST, vSize, 0)
NumPut(vSize, &HIGHCONTRAST, 0, "UInt") ;cbSize
;SPI_GETHIGHCONTRAST := 0x42
DllCall("user32\SystemParametersInfo", UInt,0x42, UInt,vSize, Ptr,&HIGHCONTRAST, UInt,0)
vFlags := NumGet(&HIGHCONTRAST, 4, "UInt") ;dwFlags
;JEE_Progress(vFlags, 1000)
if (vFlags & 1) ;HCF_HIGHCONTRASTON := 0x1
	vFlags -= 1
else
	vFlags += 1
;JEE_Progress(vFlags, 1000)
VarSetCapacity(HIGHCONTRAST, vSize, 0)
NumPut(vSize, &HIGHCONTRAST, 0, "UInt") ;cbSize
NumPut(vFlags, &HIGHCONTRAST, 4, "UInt") ;dwFlags
;SPI_SETHIGHCONTRAST := 0x43
DllCall("user32\SystemParametersInfo", UInt,0x43, UInt,vSize, Ptr,&HIGHCONTRAST, UInt,0)
return