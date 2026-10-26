[CmdletBinding()]
param([switch]$IncludeOptional, [switch]$IncludeSources, [switch]$VerifyOnly)
. "$PSScriptRoot\Common.ps1"
$directory = Join-Path $script:SetupRoot 'artifacts'
New-Item -ItemType Directory -Force -Path $directory | Out-Null
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
foreach ($entry in (Get-SetupLock).artifacts) {
    if ($entry.optional -and !$IncludeOptional) { continue }
    $path = Get-ArtifactPath $entry.id
    if (!(Test-Path -LiteralPath $path)) {
        if ($VerifyOnly) { throw "Missing artifact: $($entry.fileName)" }
        $temporary = "$path.download"
        Write-Host "Downloading pinned $($entry.id) $($entry.version)..."
        Invoke-WebRequest -Uri $entry.url -OutFile $temporary -UseBasicParsing
        if ((Get-Item -LiteralPath $temporary).Length -ne $entry.size -or
            (Get-ReadOnlySha256 $temporary) -ne $entry.sha256) {
            throw "Download verification failed: $($entry.id). File retained as .download for diagnosis."
        }
        Move-Item -LiteralPath $temporary -Destination $path -Force
    }
    $verified = Assert-Artifact $entry.id
    [pscustomobject]@{ Artifact = $entry.id; Version = $entry.version; SHA256 = 'OK'; Path = $verified }
}
if ($IncludeSources) {
    $sourceLock = 'source-archives.lock.json'
    if ($env:FERMATA_SETUP_PROFILE -eq 's25-reported') { $sourceLock = 'profiles/s25-sources.lock.json' }
    $sources = Get-Content -LiteralPath (Join-Path $script:SetupRoot $sourceLock) -Raw | ConvertFrom-Json
    foreach ($entry in $sources.archives) {
        $path = Join-Path $directory $entry.fileName
        if (!(Test-Path -LiteralPath $path)) {
            if ($VerifyOnly) { throw "Missing source archive: $($entry.fileName)" }
            $temporary = "$path.download"
            Invoke-WebRequest -Uri $entry.url -OutFile $temporary -UseBasicParsing -Headers @{ 'User-Agent' = 'Fermata-S23-Setup' }
            if ((Get-Item -LiteralPath $temporary).Length -ne $entry.size -or
                (Get-ReadOnlySha256 $temporary) -ne $entry.sha256) {
                throw "Source archive checksum mismatch: $($entry.fileName)"
            }
            Move-Item -LiteralPath $temporary -Destination $path -Force
        }
        if ((Get-Item -LiteralPath $path).Length -ne $entry.size -or
            (Get-ReadOnlySha256 $path) -ne $entry.sha256) {
            throw "Source archive verification failed: $($entry.fileName)"
        }
        [pscustomobject]@{ Artifact = $entry.fileName; Version = 'source'; SHA256 = 'OK'; Path = $path }
    }
}
