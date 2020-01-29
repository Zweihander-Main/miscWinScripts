Do {
    Sleep 3
    Set-Content -Path '.\switchSetting.ini' -Value '[switchSection]','switchStatus=false'
    $currentuser = gwmi -Class win32_computersystem | select -ExpandProperty username
    $process = get-process logonui -ea silentlycontinue
}
While (!($currentuser -and $process))
Set-Content -Path '.\switchSetting.ini' -Value '[switchSection]','switchStatus=true'