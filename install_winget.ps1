winget install --id=Microsoft.dotNetFramework -e  && winget install --id=7zip.7zip -e  && winget install --id=Adobe.AdobeAcrobatReaderDC -e  && winget install --id=Famatech.AdvancedIPScanner -e  && winget install --id=Anaconda.Anaconda3 -e  && winget install --id=angryziber.AngryIPScanner -e  && winget install --id=Balena.Etcher -e  && winget install --id=Belarc.Advisor -e  && winget install --id=BlueJeans.BlueJeans -e  && winget install --id=BraveSoftware.BraveBrowser -e  && winget install --id=SingularLabs.CCEnhancer -e  && winget install --id=Piriform.CCleaner -e  && winget install --id=EFF.Certbot -e  && winget install --id=Cisco.CiscoWebexMeetings -e  && winget install --id=Iterate.Cyberduck -e  && winget install --id=Piriform.Defraggler -e  && winget install --id=Dell.CommandUpdate -e  && winget install --id=TimKosse.FileZilla.Client -e  && winget install --id=GitHub.GitHubDesktop -e  && winget install --id=Google.Chrome -e  && winget install --id=LogMeIn.GoToMeeting -e  && winget install --id=Grammarly.ForWindows -e  && winget install --id=grammarly.grammarlyforoffice -e  && winget install --id=Apple.iTunes -e  && winget install --id=Oracle.JavaRuntimeEnvironment -e  && winget install --id=Joplin.Joplin -e  && winget install --id=DominikReichl.KeePass -e  && winget install --id=Logitech.Options -e  && winget install --id=Microsoft.Office -e  && winget install --id=Microsoft.Edge -e  && winget install --id=Microsoft.EdgeWebView2Runtime -e  && winget install --id=Microsoft.OneDriveInsiders -e  && winget install --id=Microsoft.Teams -e  && winget install --id=Microsoft.VisualStudioCode -e  && winget install --id=Mozilla.Firefox -e  && winget install --id=Insecure.Nmap -e  && winget install --id=NordVPN.NordVPN -e  && winget install --id=Notepad++.Notepad++ -e  && winget install --id=OpenVPNTechnologies.OpenVPN -e  && winget install --id=Microsoft.PowerShell -e  && winget install --id=JetBrains.PyCharm.Community.EAP -e  && winget install --id=Python.Python.3 -e  && winget install --id=OpenWhisperSystems.Signal -e  && winget install --id=OpenWhisperSystems.Signal.Beta -e  && winget install --id=TechSmith.Snagit -e  && winget install --id=Spotify.Spotify -e  && winget install --id=SublimeHQ.SublimeText.4 -e  && winget install --id=Doist.Todoist -e  && winget install --id=VideoLAN.VLC -e  && winget install --id=VMware.WorkstationPlayer -e  && winget install --id=VMware.WorkstationPro -e  && winget install --id=WhatsApp.WhatsApp -e  && winget install --id=Microsoft.WindowsTerminal -e  && winget install --id=WinSCP.WinSCP -e  && winget install --id=Corel.WinZip -e  && winget install --id=WiresharkFoundation.Wireshark -e  && winget install --id=Zoom.Zoom -e 

#Install WinGet
#Based on this gist: https://gist.github.com/crutkas/6c2096eae387e544bd05cde246f23901
$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
    "Installing winget Dependencies"
    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1

    "Installing winget from $($latestRelease.browser_download_url)"
    Add-AppxPackage -Path $latestRelease.browser_download_url
}
else {
    "winget already installed"
}

#Configure WinGet
Write-Output "Configuring winget"

#winget config path from: https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md#file-location
$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json";
$settingsJson = 
@"
    {
        // For documentation on these settings, see: https://aka.ms/winget-settings
        "experimentalFeatures": {
          "experimentalMSStore": true,
        }
    }
"@;
$settingsJson | Out-File $settingsPath -Encoding utf8

#Install New apps
Write-Output "Installing Apps"
$apps = @(
    @{name = "Microsoft.AzureCLI" }, 
    @{name = "Microsoft.PowerShell" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "Microsoft.WindowsTerminal"; source = "msstore" }, 
    @{name = "Microsoft.AzureStorageExplorer" }, 
    @{name = "Microsoft.PowerToys" }, 
    @{name = "Git.Git" }, 
    @{name = "Docker.DockerDesktop" },
    @{name = "Microsoft.dotnet" },
    @{name = "GitHub.cli" }
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --silent $app.name --source $app.source
        }
        else {
            winget install --exact --silent $app.name 
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}

#Remove Apps
Write-Output "Removing Apps"

$apps = "*3DPrint*", "Microsoft.MixedReality.Portal"
Foreach ($app in $apps)
{
  Write-host "Uninstalling:" $app
  Get-AppxPackage -allusers $app | Remove-AppxPackage
}

# To run the above script from a website, load it to GitHub and replace the URL in the line below
# https://chrislayers.com/2021/08/01/scripting-winget/
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://gist.githubusercontent.com/Codebytes/29bf18015f6e93fca9421df73c6e512c/raw/'))"