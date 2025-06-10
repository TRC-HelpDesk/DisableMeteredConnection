<#
Disable Metered Connection for the Network Interface
We create a Scheduled Task Action that runs a powershell script line that modifies the registry key that configures Metered Connection
for reach network interface.
Using the COM API, 
#>
$taskAction = New-ScheduledTaskAction -Execute "Powershell" -Argument "Set-ItemProperty -Path '.\ChangeConfigureMetered.ps1"
Register-ScheduledTask -TaskName "RunConfigureMetered" -Action $taskAction

# Register the task with COM API
$service = New-Object -ComObject 'Schedule.Service'
$service.Connect()

$trusted = "NT SERVICE\TrustedInstaller"
$folder = $service.GetFolder('\')
$task = $folder.GetTask("RunConfigureMetered")
$task.RunEx($null, 0, 0, $trusted)

Unregister-ScheduledTask -Taskname "RunConfigureMetered" -Confirm:$false