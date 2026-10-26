Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$script:SetupRoot = Split-Path -Parent $PSScriptRoot

function Get-SetupLock {
    $name = 'versions.lock.json'
    if ($env:FERMATA_SETUP_PROFILE) {
        switch ($env:FERMATA_SETUP_PROFILE) {
            's23-legacy' { }
            's25-reported' { $name = 'profiles/s25-reported.lock.json' }
            default { throw 'Unknown FERMATA_SETUP_PROFILE. Use s23-legacy or s25-reported.' }
        }
    }
    Get-Content -LiteralPath (Join-Path $script:SetupRoot $name) -Raw | ConvertFrom-Json
}

function Get-ArtifactPath([string]$Id) {
    $entry = (Get-SetupLock).artifacts | Where-Object { $_.id -eq $Id }
    if (!$entry) { throw "Unknown artifact: $Id" }
    Join-Path (Join-Path $script:SetupRoot 'artifacts') $entry.fileName
}

function Get-ReadOnlySha256([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try {
        ([BitConverter]::ToString($algorithm.ComputeHash($stream))).Replace('-','').ToLowerInvariant()
    } finally {
        $algorithm.Dispose()
        $stream.Dispose()
    }
}

function Assert-Artifact([string]$Id) {
    # Hash calculation is read-only and must still work under a caller's -WhatIf.
    $WhatIfPreference = $false
    $entry = (Get-SetupLock).artifacts | Where-Object { $_.id -eq $Id }
    if (!$entry) { throw "Unknown artifact: $Id" }
    $path = Get-ArtifactPath $Id
    if (!(Test-Path -LiteralPath $path)) { throw "Missing $Id. Run Get-Artifacts.ps1 first." }
    if ((Get-Item -LiteralPath $path).Length -ne $entry.size) { throw "Size mismatch: $Id" }
    if ((Get-ReadOnlySha256 $path) -ne $entry.sha256) {
        throw "SHA256 mismatch: $Id"
    }
    $path
}

function Find-Adb([string]$AdbPath) {
    $WhatIfPreference = $false
    if ($AdbPath) {
        if (!(Test-Path -LiteralPath $AdbPath)) { throw "ADB does not exist: $AdbPath" }
        return [IO.Path]::GetFullPath($AdbPath)
    }
    $candidates = @((Join-Path $script:SetupRoot 'artifacts\platform-tools\adb.exe'))
    if ($env:ANDROID_SDK_ROOT) { $candidates += Join-Path $env:ANDROID_SDK_ROOT 'platform-tools\adb.exe' }
    if ($env:ANDROID_HOME) { $candidates += Join-Path $env:ANDROID_HOME 'platform-tools\adb.exe' }
    if ($env:LOCALAPPDATA) { $candidates += Join-Path $env:LOCALAPPDATA 'Android\Sdk\platform-tools\adb.exe' }
    foreach ($path in $candidates) { if (Test-Path -LiteralPath $path) { return $path } }
    $cmd = Get-Command adb -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    throw 'ADB not found. Run Install-DesktopTools.ps1 or pass -AdbPath.'
}

function Invoke-DeviceAdb {
    param([string]$Adb, [string]$Serial, [string[]]$Arguments)
    $output = @(& $Adb -s $Serial @Arguments)
    if ($LASTEXITCODE -ne 0) { throw "ADB failed ($LASTEXITCODE): $($Arguments -join ' ')" }
    $output
}

function Resolve-Device([string]$Adb, [string]$Serial) {
    $listing = @(& $Adb devices)
    if ($LASTEXITCODE -ne 0) { throw 'Unable to list ADB devices.' }
    $devices = @($listing | ForEach-Object {
        if ($_ -match '^(\S+)\s+device\s*$') { $Matches[1] }
    })
    if ($Serial) {
        if ($devices -notcontains $Serial) { throw 'Selected serial is not connected and authorized.' }
        return $Serial
    }
    if ($devices.Count -ne 1) {
        throw 'Connect one authorized device, or specify -Serial from adb devices. Do not target Secure Folder.'
    }
    $devices[0]
}

function Get-PackageField([string]$Dump, [string]$Field) {
    $match = [regex]::Match($Dump, '(?m)^\s*' + [regex]::Escape($Field) + '=(\S+)')
    if ($match.Success) { return $match.Groups[1].Value }
    return $null
}
