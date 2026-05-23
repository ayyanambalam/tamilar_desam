$ErrorActionPreference = "Stop"

Write-Host "Tamilar Desam - project setup" -ForegroundColor Cyan
Write-Host "This script creates a Flutter project and copies the provided app sources into it." -ForegroundColor Gray

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw "Flutter is not installed or not in PATH. Install Flutter first: https://flutter.dev/docs/get-started/install"
}

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$target = Join-Path $here "..\tamilar_desam_flutter_project"
Write-Host "Target folder: $target" -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $target | Out-Null
$target = (Resolve-Path $target).Path

Push-Location $target
try {
  if (-not (Test-Path (Join-Path $target "pubspec.yaml"))) {
    flutter create . --org com.tamilardesam --project-name tamilar_desam | Out-Null
  }

  $srcRoot = $here

  Copy-Item -Force (Join-Path $srcRoot "pubspec.yaml") (Join-Path $target "pubspec.yaml")
  Copy-Item -Force (Join-Path $srcRoot "analysis_options.yaml") (Join-Path $target "analysis_options.yaml")

  if (Test-Path (Join-Path $target "assets")) { Remove-Item -Recurse -Force (Join-Path $target "assets") }
  if (Test-Path (Join-Path $target "lib")) { Remove-Item -Recurse -Force (Join-Path $target "lib") }

  Copy-Item -Recurse -Force (Join-Path $srcRoot "assets") (Join-Path $target "assets")
  Copy-Item -Recurse -Force (Join-Path $srcRoot "lib") (Join-Path $target "lib")

  flutter pub get
  Write-Host "`nDone. Next:" -ForegroundColor Green
  Write-Host "1) Add android/app/google-services.json" -ForegroundColor Green
  Write-Host "2) flutter run" -ForegroundColor Green
} finally {
  Pop-Location
}
