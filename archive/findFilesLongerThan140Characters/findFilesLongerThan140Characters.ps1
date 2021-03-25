# Get-ChildItem "Z:\Musix" -recurse | Where {$_.GetType().Name -match "Directory|File" -and $_.Name.Length -ge 140} | Foreach {$_.FullName}
Get-ChildItem "Z:\" -recurse | Where {$_.GetType().Name -match "Directory|File"} | Foreach {
    $charLength = $_.Name.Length
    $theName = $_.FullName
    Select-String [^\x00-\x7F]+ -input $_.Name -AllMatches | Foreach {
        $totalMatchesLength = 0
        Foreach($match in $_.matches.Value) {
            $totalMatchesLength = $totalMatchesLength + $match.Length
        }
        $theValue = $charLength + ($totalMatchesLength * 2.3)
        if ($theValue -ge 140) {
            "$theValue : $theName"
        }
    }
}