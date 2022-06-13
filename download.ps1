$filelist = gc wget-list
$counter = 1
$fail = 0
$useragent = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36"

foreach ($file in $filelist)
{    
	$outfile = ".\download\$(split-path -path $file -leaf)"
	try {
		Write-Host "$counter. Downloading $outfile from URI $file"
		Invoke-WebRequest -URI $file -UseBasicParsing -OutFile "$outfile" -UserAgent $useragent
	} 
	catch {
        $fail += 1
		Write-Host "$fail. Cannot Download from URI $file"
	}
    $counter += 1
}

