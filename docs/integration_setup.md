# Integration Setup

## GitHub
This workspace is initialized as a Git repository and linked to:

`https://github.com/Dev-up1/Barq-App.git`

Suggested first push after installing Flutter and validating the app:

```bash
git add .
git commit -m "feat: bootstrap Barq Recharge Flutter foundation"
git push -u origin main
```

## Supabase
The app reads Supabase values from compile-time environment variables.

Required keys:
- `SUPABASE_URL`
- `SUPABASE_PUBLISHABLE_KEY`
- `AGGREGATOR_API_BASE_URL`
- `AGGREGATOR_API_TOKEN`
- `PSI_OVERRIDE_URL` (optional)
- `AGGREGATOR_SMS_NUMBER`
- `AGGREGATOR_SMS_TEMPLATE` (optional)
- `WHATSAPP_SUPPORT_NUMBER`
- `WHATSAPP_SUPPORT_TEMPLATE` (optional)

## Android Test APK
Current project target for mobile testing is a debug Android APK with:
- real Supabase client configuration
- demo aggregator placeholders
- local Drift database on-device

Quick build command after Android SDK is installed:

```powershell
.\scripts\build_test_apk.ps1
```

Direct manual command:

```powershell
D:\flutter\bin\flutter.bat build apk --debug `
  --dart-define=SUPABASE_URL=https://nbdoveppvfdygeddwcey.supabase.co `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=sb_publishable_XemzjySUsIR0eEF06LyMFw_TkWKJSKl `
  --dart-define=AGGREGATOR_API_BASE_URL=https://demo-aggregator.invalid `
  --dart-define=AGGREGATOR_API_TOKEN=demo_token `
  --dart-define=AGGREGATOR_SMS_NUMBER=770000000 `
  --dart-define=WHATSAPP_SUPPORT_NUMBER=967770000000
```

Expected output APK path:

```text
build\app\outputs\flutter-apk\app-debug.apk
```

Example run command:

```bash
flutter run ^
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_SUPABASE_PUBLISHABLE_KEY ^
  --dart-define=AGGREGATOR_API_BASE_URL=YOUR_AGGREGATOR_API_BASE_URL ^
  --dart-define=AGGREGATOR_API_TOKEN=YOUR_AGGREGATOR_API_TOKEN ^
  --dart-define=PSI_OVERRIDE_URL=YOUR_OPTIONAL_PSI_OVERRIDE_URL ^
  --dart-define=AGGREGATOR_SMS_NUMBER=YOUR_SMS_GATEWAY_NUMBER ^
  --dart-define=AGGREGATOR_SMS_TEMPLATE="REF:{reference};PSI:{psi_code};TARGET:{target};AMOUNT:{base_amount};TAX:{tax_amount};TOTAL:{total_amount}" ^
  --dart-define=WHATSAPP_SUPPORT_NUMBER=9677XXXXXXX ^
  --dart-define=WHATSAPP_SUPPORT_TEMPLATE="مرحبا، لدي مشكلة في عملية {transaction_reference} من الحساب {user_id} على الإصدار {app_version}"
```

Notes:
- Do not commit database passwords or service-role secrets into the repository.
- Use the publishable key on the client app.
- Keep database credentials server-side only.
- تفعيل البصمة يتطلب إعدادات Android/iOS الخاصة بحزمة `local_auth`.
- تصدير تقرير العمولة الشهري يتطلب أذونات التخزين/المشاركة بحسب المنصة ومسار حفظ الملف.

## Current Limitation
- Flutter SDK is still missing from this machine, so dependency install and runtime verification could not be executed yet.
