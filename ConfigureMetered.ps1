# This will set Ethernet Network as Non-Metered
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost' -Name 'Ethernet' -Type 'DWord' -Value '00000001'

# We restart the NetMan service
Stop-Service -Name "Netman"
Start-Service -Name "Netman"