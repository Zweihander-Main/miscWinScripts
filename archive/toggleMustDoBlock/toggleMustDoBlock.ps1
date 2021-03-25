# Enable should be false or true from command line arguments
 param (
    [string]$enable = $true
 )
($TaskScheduler = New-Object -ComObject Schedule.Service).Connect("localhost")
$MyTask = $TaskScheduler.GetFolder('\ZweiScripts').GetTask("Trigger Must Do Blocklist")
$MyTask.Enabled = $enable