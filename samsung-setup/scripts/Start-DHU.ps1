[CmdletBinding()]
param([string]$Serial, [string]$AdbPath, [string]$DhuPath)
. "$PSScriptRoot\Common.ps1"
$adb = Find-Adb $AdbPath
$device = Resolve-Device $adb $Serial
if (!$DhuPath) { $DhuPath = Join-Path $script:SetupRoot 'artifacts\dhu-2.1\desktop-head-unit.exe' }
if (!(Test-Path -LiteralPath $DhuPath)) { throw 'DHU missing. Run Install-DesktopTools.ps1 first.' }
$directory = Split-Path -Parent (Resolve-Path -LiteralPath $DhuPath).Path
$configuration = Join-Path $directory 'config\default_720p.ini'
if (!(Test-Path -LiteralPath $configuration)) { throw 'DHU config/default_720p.ini is missing.' }
Invoke-DeviceAdb $adb $device @('forward','tcp:5277','tcp:5277')
Write-Host 'Enable Android Auto > More options > Start head unit server on the phone.'
Write-Host 'In DHU: app launcher > Fermata Auto (blue play icon). Use normal Fermata first, not FS Mirror.'
Write-Host 'The simulator is a developer head unit. Test the physical car separately while parked.'
Push-Location $directory
try {
    & $DhuPath "--config=$configuration" '--adb=127.0.0.1:5277'
    if ($LASTEXITCODE -ne 0) { throw "DHU exited with code $LASTEXITCODE" }
} finally { Pop-Location }
