[CmdletBinding(SupportsShouldProcess)]
param()
. "$PSScriptRoot\Common.ps1"
$adbZip = Assert-Artifact 'platform-tools'
$dhuZip = Assert-Artifact 'dhu'
$artifacts = Join-Path $script:SetupRoot 'artifacts'
if ($PSCmdlet.ShouldProcess($artifacts, 'Extract verified Android Platform Tools and DHU 2.1 preview')) {
    Expand-Archive -LiteralPath $adbZip -DestinationPath $artifacts -Force
    Expand-Archive -LiteralPath $dhuZip -DestinationPath (Join-Path $artifacts 'dhu-2.1') -Force
    & (Join-Path $artifacts 'platform-tools\adb.exe') version
    if ($LASTEXITCODE -ne 0) { throw 'Extracted ADB could not run.' }
    & (Join-Path $artifacts 'dhu-2.1\desktop-head-unit.exe') --version
    if ($LASTEXITCODE -ne 0) { throw 'Extracted DHU could not run.' }
}
