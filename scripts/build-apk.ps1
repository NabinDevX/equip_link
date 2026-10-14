[CmdletBinding()]
param(
    [string]$ApiUrl = $env:EQUIPLINK_API_URL,
    [string]$GoogleServerClientId = $env:GOOGLE_SERVER_CLIENT_ID
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$flutterProject = Join-Path $repoRoot 'equip_link_flutter'
$outputDirectory = Join-Path $repoRoot 'docs'
$apkSource = Join-Path $flutterProject 'build\app\outputs\flutter-apk\app-release.apk'
$apkDestination = Join-Path $outputDirectory 'equiplink.apk'
$rootEnvFile = Join-Path $repoRoot '.env'

function Read-EnvValue([string]$Name) {
    if (-not (Test-Path -LiteralPath $rootEnvFile -PathType Leaf)) { return $null }
    foreach ($line in Get-Content -LiteralPath $rootEnvFile) {
        if ($line -match ('^\s*' + [regex]::Escape($Name) + '\s*=\s*(.*)$')) {
            $value = $Matches[1].Trim()
            if ($value.Length -ge 2 -and (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'")))) {
                $value = $value.Substring(1, $value.Length - 2)
            }
            return $value
        }
    }
    return $null
}

if ([string]::IsNullOrWhiteSpace($ApiUrl)) { $ApiUrl = Read-EnvValue 'EQUIPLINK_API_URL' }
if ([string]::IsNullOrWhiteSpace($GoogleServerClientId)) { $GoogleServerClientId = Read-EnvValue 'GOOGLE_SERVER_CLIENT_ID' }

if ([string]::IsNullOrWhiteSpace($ApiUrl)) {
    throw 'Provide the deployed HTTPS API URL with -ApiUrl or EQUIPLINK_API_URL. Example: https://your-project.api.serverpod.space/'
}

try {
    $apiUri = [Uri]$ApiUrl
}
catch {
    throw 'ApiUrl must be a valid absolute HTTPS URL.'
}

if (-not $apiUri.IsAbsoluteUri -or $apiUri.Scheme -ne 'https' -or [string]::IsNullOrWhiteSpace($apiUri.Host)) {
    throw 'ApiUrl must be a valid absolute HTTPS URL. Release APKs cannot use the current local HTTP/LAN endpoint.'
}

if ([string]::IsNullOrWhiteSpace($GoogleServerClientId) -or
    $GoogleServerClientId -notmatch '^[0-9]+-[A-Za-z0-9_-]+\.apps\.googleusercontent\.com$') {
    throw 'Provide the Google OAuth Web client ID with -GoogleServerClientId or GOOGLE_SERVER_CLIENT_ID.'
}

$normalizedApiUrl = $ApiUrl.TrimEnd('/') + '/'
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null

Push-Location $repoRoot
try {
    Write-Host 'Resolving Flutter workspace dependencies...'
    flutter pub get
    if ($LASTEXITCODE -ne 0) {
        throw "flutter pub get failed with exit code $LASTEXITCODE."
    }

    Push-Location $flutterProject
    try {
        Write-Host 'Building the release APK...'
        flutter build apk --release --no-pub `
            "--dart-define=SERVER_URL=$normalizedApiUrl" `
            "--dart-define=GOOGLE_SERVER_CLIENT_ID=$GoogleServerClientId"
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter APK build failed with exit code $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
    }

    if (-not (Test-Path -LiteralPath $apkSource -PathType Leaf)) {
        throw "Flutter reported success, but the APK was not found at $apkSource."
    }

    Copy-Item -LiteralPath $apkSource -Destination $apkDestination -Force
    Write-Host "APK created: $apkDestination"
}
finally {
    Pop-Location
}
