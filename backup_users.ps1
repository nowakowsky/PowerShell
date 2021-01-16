Write-Host "This script copies whole C:\Users\ without trashes. Remember to list users you DO NOT want to copy"
#If you want to copy only listed users just change line 28 to "if ($user -in $NOT_wanted_profiles)"
$source_ip = Read-Host -Prompt "Source IP address? (eg 192.168.200.1)"
$dest_path = Read-Host -Prompt "Where to save data? (eg \\192.168.200.2\c$\Users\)"

$dirs_to_copy = @(
    'Desktop'
    'Downloads'
    'Documents'
    'Pictures'
    'Videos',
    'Music'
    )

$SourceRoot = "\\$source_ip\c$\Users\"

$users = New-Object -TypeName "System.Collections.ArrayList"

$NOT_wanted_profiles = @(
    'ansible'
    'Public'
    'sccm_admin'
)
Get-ChildItem $SourceRoot | % { ($users.Add($_.Name)) }

foreach ($user in $users)
{
    if ($user -notin $NOT_wanted_profiles)
    {
       $Destination = Join-Path -Path $dest_path -ChildPath $user
    $Source = Join-Path -Path $SourceRoot -ChildPath $user
    foreach ($folder in $dirs_to_copy)
    {
        $Destination_F = Join-Path -Path $Destination -ChildPath $folder
        $Source_F = Join-Path -Path $Source -ChildPath $folder
        robocopy $Source_F $Destination_F /S /NFL /NS /NC /NDL /ETA
    }
    }
}
