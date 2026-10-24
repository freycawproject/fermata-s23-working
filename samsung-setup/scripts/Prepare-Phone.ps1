[CmdletBinding(SupportsShouldProcess)]
param([string]$Serial, [string]$AdbPath, [switch]$IncludeShizuku)
. "$PSScriptRoot\Common.ps1"
$adb = Find-Adb $AdbPath
$device = Resolve-Device $adb $Serial
$fermata = Assert-Artifact 'fermata'
$king = Assert-Artifact 'kinginstaller'
$shizuku = $null
if ($IncludeShizuku) { $shizuku = Assert-Artifact 'shizuku' }
$abi = (Invoke-DeviceAdb $adb $device @('shell','getprop','ro.product.cpu.abi')) -join ''
if ($abi.Trim() -ne 'arm64-v8a') { throw 'This kit contains only the verified arm64 APK.' }
if ($PSCmdlet.ShouldProcess('Selected device, user 0', 'Install KingInstaller 2.3, copy Fermata APK, and open KingInstaller')) {
    Invoke-DeviceAdb $adb $device @('install','-r','--user','0',$king)
    Invoke-DeviceAdb $adb $device @('push',$fermata,'/sdcard/Download/fermata-auto-2.0.1-arm64.apk')
    if ($IncludeShizuku) {
        Invoke-DeviceAdb $adb $device @('install','-r','--user','0',$shizuku)
    }
    Invoke-DeviceAdb $adb $device @('shell','am','start','-n','com.example.kinginstaller/.MainActivity')
}
Write-Host 'Next: follow docs/INSTALL.id.md. Install Fermata through KingInstaller classic, not adb install.'
Write-Host 'Select Package installer > Just once > Update if Fermata is already installed.'
Write-Host 'This script never uninstalls Fermata or clears application data.'
