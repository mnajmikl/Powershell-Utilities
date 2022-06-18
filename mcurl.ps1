$filelist = (gc wget-list)
$counter = 1
$fail = 0

foreach ($file in $filelist)
{    
	$outfile = "$(split-path -path $file -leaf)"
	try {
		Write-Host "$counter. Downloading $outfile from URI $file"
		curl --output $outfile --location-trusted --http1.1 --ignore-content-length $file
	} 
	catch {
		$fail += 1
		Write-Host "$fail. Cannot Download from URI $file"
	}
    $counter += 1
}

