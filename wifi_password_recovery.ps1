netsh wlan show profile | findstr All | % { $_.substring(27); Write-Host ($_.substring(27)) } 2> $null | % { netsh wlan show profile $_ key=clear} | findstr Key | % { $_.substring(29) }
