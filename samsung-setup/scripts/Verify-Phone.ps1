[CmdletBinding()]
param([string]$Serial, [string]$AdbPath, [switch]$Launch, [string]$OutFile)
. "$PSScriptRoot\Common.ps1"
$adb = Find-Adb $AdbPath
$device = Resolve-Device $adb $Serial
$pkg = (Get-SetupLock).fermataPackage
$dump = (Invoke-DeviceAdb $adb $device @('shell','dumpsys','package',$pkg)) -join "`n"
$aa = (Invoke-DeviceAdb $adb $device @('shell','dumpsys','package','com.google.android.projection.gearhead')) -join "`n"
if ($Launch) {
    Invoke-DeviceAdb $adb $device @('shell','am','start','-n',"$pkg/me.aap.fermata.ui.activity.MainActivity") | Out-Null
    Start-Sleep -Seconds 3
}
$process = @(& $adb -s $device shell pidof $pkg)
$alive = $LASTEXITCODE -eq 0 -and (($process -join '').Trim().Length -gt 0)
$crash = (Invoke-DeviceAdb $adb $device @('logcat','-b','crash','-d')) -join "`n"
$overlay = (Invoke-DeviceAdb $adb $device @('shell','appops','get',$pkg,'SYSTEM_ALERT_WINDOW')) -join "`n"
$installer = Get-PackageField $dump 'installerPackageName'
$initiator = Get-PackageField $dump 'initiatingPackageName'
$expectedVersion = ((Get-SetupLock).artifacts | Where-Object { $_.id -eq 'fermata' }).version
$result = [pscustomobject][ordered]@{
    ObservedAt = (Get-Date).ToUniversalTime().ToString('o')
    SetupProfile = $(if ($env:FERMATA_SETUP_PROFILE) { $env:FERMATA_SETUP_PROFILE } else { 's23-legacy' })
    Model = ((Invoke-DeviceAdb $adb $device @('shell','getprop','ro.product.model')) -join '').Trim()
    Android = ((Invoke-DeviceAdb $adb $device @('shell','getprop','ro.build.version.release')) -join '').Trim()
    FermataVersion = Get-PackageField $dump 'versionName'
    ExpectedFermataVersion = $expectedVersion
    MatchesSelectedVersion = ((Get-PackageField $dump 'versionName') -eq $expectedVersion)
    AndroidAutoVersion = Get-PackageField $aa 'versionName'
    InstallerPackage = $installer
    InitiatingPackage = $initiator
    OriginatingPackage = Get-PackageField $dump 'originatingPackageName'
    MatchesTestedInstallerPattern = ($installer -eq 'com.android.vending' -and $initiator -eq 'com.google.android.packageinstaller')
    DeclaresCarAppService = $dump.Contains('androidx.car.app.CarAppService:')
    DeclaresMediaBrowserService = $dump.Contains('android.media.browse.MediaBrowserService:')
    OverlayAllowed = ($overlay -match 'SYSTEM_ALERT_WINDOW:\s*allow')
    MediaVideoGranted = ($dump -match 'android.permission.READ_MEDIA_VIDEO: granted=true')
    MediaAudioGranted = ($dump -match 'android.permission.READ_MEDIA_AUDIO: granted=true')
    ProcessAlive = [bool]$alive
    FermataCrashInAvailableBuffer = ($crash -match ('Process:\s*' + [regex]::Escape($pkg) + '(?:,|\s|$)'))
    VideoVisuallyVerified = 'Manual check required: changing frames in DHU'
    PhysicalCarVerified = $false
    PublicPresetImported = 'Manual check required: native import, reopen, voice id-ID and TV source indo'
    Note = 'Service declarations and installer records do not prove host acceptance. Crash buffer covers only retained logs.'
}
if ($OutFile) {
    $parent = Split-Path -Parent ([IO.Path]::GetFullPath($OutFile))
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    $result | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $OutFile -Encoding UTF8
}
$result
