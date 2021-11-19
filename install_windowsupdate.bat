:: Bypass the ExecutionPolicy in PowerShell
@powershell Set-ExecutionPolicy RemoteSigned

:: Trust the PSGallery repository
@powershell Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

:: Install PSWindowsUpdate
ECHO Y | @powershell Install-Module -Name PSWindowsUpdate | ECHO Y
@powershell Get-Package -Name PSWindowsUpdate

:: Find and install updates
:: @powershell Install-WindowsUpdate -AcceptAll -AutoReboot