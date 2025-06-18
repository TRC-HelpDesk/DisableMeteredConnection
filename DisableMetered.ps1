$adapters = Get-NetAdapter | Where-Object { $_.Name -like "*Ethernet*"}

foreach ($adapter in $adapters){
    $NIC_GUID = $adapter.InterfaceGUID
    # This is the new registry path that Settings uses to determine Metered Connections per Network Interface
    $RegistryPath = "HKLM:\\Software\Microsoft\DusmSvc\Profiles\$NIC_GUID\*"
    if (Test-Path -Path $RegistryPath){
        # If hte path exists make sure etherenet is set to Metered before switching
        $UserCost = (Get-ItemProperty -Path $RegistryPath -Name UserCost).UserCost
        if($UserCost -ne 0){
            Write-Host "Switching from Metered to Non-Metered connection on this network interface"
            Set-ItemProperty -Path $RegistryPath -Name UserCost -Value 0
        }
    }
}

Restart-Service -Name DusmSvc -Force