$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$buildScript = Join-Path $PSScriptRoot 'build-apk.ps1'
$apkPath = Join-Path $repoRoot 'docs\equiplink.apk'

Write-Host 'Building the Android APK before commit...'
& $buildScript

if (-not (Test-Path -LiteralPath $apkPath -PathType Leaf)) {
    throw "APK build completed without creating $apkPath."
}

git -C $repoRoot add -- docs/equiplink.apk
if ($LASTEXITCODE -ne 0) {
    throw 'Could not stage docs/equiplink.apk.'
}

Write-Host 'Updated docs/equiplink.apk and staged it for this commit.'
