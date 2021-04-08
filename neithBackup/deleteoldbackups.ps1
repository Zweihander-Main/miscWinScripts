# fully qualified path to the root folder
$root = 'H:'
# date threshold, ten days ago from today
$threshold = [DateTime]::Today.AddDays(-30)
# retrieve root folder items
Get-ChildItem -Path $root | Where-Object {
  # attempt to convert folder name to DateTime
  $asDate = if ($_.PSIsContainer) {
    $_.Name -replace '^(.{4})(..)(..)$','$1/$2/$3' -as [DateTime]
  }
  # filter folders whose names can be converted to DateTime
  # and are older than the threshold
  $asDate -and $asDate -lt $threshold
} | Remove-Item -Recurse -Verbose
pause
