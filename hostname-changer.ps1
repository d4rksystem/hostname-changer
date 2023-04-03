#################################################
## hostname-changer.ps1: A quick and dirty script to change the local username, hostname, and DNS name (domain) of the host. Designed for malware sandboxes :)
##################################################
## Author: d4rksystem (Kyle Cucci)
## Version: 0.2
##################################################

Param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string] $CurrentLocalUserName,
  [Parameter(Mandatory = $true, Position = 0)]
  [string] $NewLocalUserName,
  [Parameter(Mandatory = $true, Position = 1)]
  [string] $NewHostname,
  [Parameter(Mandatory = $true, Position = 2)]
  [string] $NewDomainName
)

Write-Output "[+] Changing local username '$CurrentLocalUserName' to '$NewLocalUserName'..."
Rename-LocalUser -Name $CurrentLocalUserName -NewName $NewLocalUserName

Write-Output "[+] Changing compuer name to '$NewHostname'..."
Rename-Computer -NewName $NewHostname

Write-Output "[+] Adding host to a domain '$NewDomainName'..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\" -Name "Domain" -Value $NewDomainName -Force

Write-Output "[+] Done! Machine will reboot in 10 seconds!"
Start-Sleep -Seconds 10
Restart-Computer
