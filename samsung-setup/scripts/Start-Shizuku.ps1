[CmdletBinding(SupportsShouldProcess)]
param([string]$Serial, [string]$AdbPath)
. "$PSScriptRoot\Common.ps1"
$adb = Find-Adb $AdbPath
$device = Resolve-Device $adb $Serial
$paths = @(Invoke-DeviceAdb $adb $device @('shell','pm','path','--user','0','moe.shizuku.privileged.api'))
$base = $paths | Where-Object { $_ -match '^package:.*/base\.apk\s*$' } | Select-Object -First 1
if (!$base) { throw 'Shizuku is not installed for user 0. Use Prepare-Phone.ps1 -IncludeShizuku.' }
$directory = ($base.Trim() -replace '^package:','') -replace '/base\.apk$',''
$starter = "$directory/lib/arm64/libshizuku.so"
if ($PSCmdlet.ShouldProcess('Selected device', 'Start the optional Shizuku daemon as shell, not root')) {
    Invoke-DeviceAdb $adb $device @('shell',$starter)
    Start-Sleep -Seconds 1
    $server = Invoke-DeviceAdb $adb $device @('shell','pidof','shizuku_server')
    if (!$server) { throw 'Shizuku server was not observed.' }
    Write-Host 'Shizuku is running. Grant KingInstaller access in the Shizuku UI before trying its Shizuku method.'
}
