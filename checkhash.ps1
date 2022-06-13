$filehashes = gc md5sums
$counter = 1
$fail = 0

foreach ($filehash in $filehashes)
{
	$knownhash =$filehash.split()[0]
	$filename = $filehash.split()[2]
	$filenamecheck = ".\download\$filename"
	try {
		$fileexist = Test-Path $filenamecheck
		if ($fileexist -eq "True") {
			$comparehash = (Get-FileHash $filenamecheck -Algorithm MD5).Hash
			if ($comparehash -eq $knownhash) {
				Write-Host "$counter. " -NoNewline
                Write-Host "[MATCH]" -ForegroundColor DarkGreen -BackgroundColor Black -NoNewline
                Write-Host " $filename :" -NoNewline
                Write-Host " $knownhash" -ForegroundColor DarkRed -BackgroundColor Black
                $counter = $counter + 1
			}
			else {
                $fail += 1
				Write-Host "$counter. " -NoNewline
                Write-Host "[NO MATCH]" -ForegroundColor DarkCyan -BackgroundColor Black -NoNewline
                Write-Host " $filename : " -NoNewline
                Write-Host "$knownhash" -ForegroundColor DarkRed -BackgroundColor Black -NoNewline
                Write-Host " vs Actual " -NoNewline
                Write-Host "$comparehash" -ForegroundColor DarkYellow -BackgroundColor Black -NoNewline
                Write-Host " - Fail #$fail"
			}
		}
		else {
			Write-Host "$filenamecheck does not exist"
		}
	}
	catch {
		Write-Host "Hash comparison error"
	}
}

