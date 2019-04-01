#With no arguments it will let you chose which printer to reinstall
#Reinstall-Printer Xerox 3052 or Reinstall-Printer *erox* will work as well

function Reinstall-Printer
{
    if ($args.Length -gt 0) { $Found = Get-Printer -Name $args[0] }
    else {$Found = Get-Printer -Name *}
    $chosen = 0

    foreach ($each in $Found.Name)
    {
        Write-Host "$chosen - $each"
        $chosen++
    }

    $chosen = Read-Host "Chose printer to reinstall"
    Remove-Printer -Name $Found[$chosen].Name
    Write-Host "Removing printer, please wait..."
    Start-Sleep -s 5
    Add-Printer -Name $Found[$chosen].Name -DriverName $Found[$chosen].DriverName -PortName $Found[$chosen].PortName
    Write-Host "Success! Your printer should appear in few seconds."
}

#Reinstall-Printer
