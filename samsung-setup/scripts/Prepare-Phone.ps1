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
if ($abi.Trim() -ne 'arm64-v8a') { throw 'This kit contains arm64 APKs only; do not install on another ABI.' }
$lock = Get-SetupLock
$kingVersion = ($lock.artifacts | Where-Object { $_.id -eq 'kinginstaller' }).version
$fermataName = Split-Path -Leaf $fermata
$preset = Join-Path $script:SetupRoot 'preferences/fermata-samsung-public-v1.zip'
$presetLock = Get-Content -LiteralPath (Join-Path $script:SetupRoot 'preferences/preset.lock.json') -Raw | ConvertFrom-Json
if ((Get-ReadOnlySha256 $preset) -ne $presetLock.sha256) { throw 'Public preset checksum mismatch.' }
if ($PSCmdlet.ShouldProcess('Selected device, user 0', "Install KingInstaller $kingVersion, copy Fermata APK and public preset, and open KingInstaller")) {
    Invoke-DeviceAdb $adb $device @('install','-r','--user','0',$king)
    Invoke-DeviceAdb $adb $device @('push',$fermata,"/sdcard/Download/$fermataName")
    Invoke-DeviceAdb $adb $device @('push',$preset,'/sdcard/Download/fermata-samsung-public-v1.zip')
    if ($IncludeShizuku) {
        Invoke-DeviceAdb $adb $device @('install','-r','--user','0',$shizuku)
    }
    Invoke-DeviceAdb $adb $device @('shell','am','start','-n','com.example.kinginstaller/.MainActivity')
}
Write-Host 'Next: follow docs/INSTALL.id.md. Install Fermata through KingInstaller classic, not adb install.'
Write-Host "Select $fermataName. If an installer chooser appears, use Package installer > Just once."
Write-Host 'After installation: backup existing preferences, then import the public ZIP in Fermata Settings.'
Write-Host 'Import closes Fermata; reopen and verify. ADB push alone does not import preferences.'
Write-Host 'This script never uninstalls Fermata or clears application data.'
