:: Install choco .exe and add choco to PATH
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Install all the packages
:::: Browsers
choco install microsoft-edge -fy
choco install googlechrome -fy
choco install firefox -fy

:::: Office Tools
choco install office365business -fy
choco install microsoft-teams.install -fy
:: Installs the 32-bit version of Microsoft OneDrive
:: Chocolatey at this point does not have a package for the 64-bit version
:: Uncomment the below line if you want to continue to install the 32-bit version
:: choco install onedrive -fy
choco install adobereader -fy

:::: Meeting Tools
choco install zoom -fy
choco install webex-meetings -fy
choco install gotomeeting -fy
choco install gotoopener -fy

:::: Compression Tools
choco install 7zip.install -fy
:: choco install 7zip.portable -fy

:::: Backup Tools
choco install veeam-agent -fy

:::: Media
choco install vlc -fy

:::: Utilities
:: Chocolatey GUI requires .NET 4.5.2
choco install dotnet4.5.2 -fy
choco install chocolateygui -fy
choco install displaylink -fy

:::: Text editors / IDEs
:: choco install atom -fy
choco install notepadplusplus -fy
choco install sublimetext3 -fy
choco install vscode.install -fy
choco install vscode-python -fy

:::: Dev tools
choco install git.install -fy
choco install nodejs.install -fy
choco install python3 -fy

:::: SysAdmin Tools
choco install winscp -fy
:: choco install winscp.portable -fy
choco install vmrc -fy
choco install sysinternals -fy
choco install putty -fy
:: choco install putty.portable -fy
choco install powershell-core -fy
choco install microsoft-windows-terminal -fy
choco install ccenhancer.portable -fy
choco install ccleaner.portable -fy
choco install nmap -fy
choco install wireshark -fy

:::: Other
:: choco install dropbox -fy
:: choco install slack -fy
