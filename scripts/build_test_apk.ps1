$ErrorActionPreference = 'Stop'

$flutter = 'D:\flutter\bin\flutter.bat'
$dart = 'D:\flutter\bin\dart.bat'

if (-not (Test-Path $flutter)) {
  throw "Flutter not found at $flutter"
}

if (-not (Test-Path $dart)) {
  throw "Dart not found at $dart"
}

Set-Location $PSScriptRoot\..

& $flutter pub get
& $dart run build_runner build --delete-conflicting-outputs
& $flutter build apk --debug `
  --dart-define=SUPABASE_URL=https://nbdoveppvfdygeddwcey.supabase.co `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=sb_publishable_XemzjySUsIR0eEF06LyMFw_TkWKJSKl `
  --dart-define=AGGREGATOR_API_BASE_URL=https://demo-aggregator.invalid `
  --dart-define=AGGREGATOR_API_TOKEN=demo_token `
  --dart-define=AGGREGATOR_SMS_NUMBER=770000000 `
  --dart-define=WHATSAPP_SUPPORT_NUMBER=967770000000
