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

Example run command:

```bash
flutter run ^
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_SUPABASE_PUBLISHABLE_KEY
```

Notes:
- Do not commit database passwords or service-role secrets into the repository.
- Use the publishable key on the client app.
- Keep database credentials server-side only.

## Current Limitation
- Flutter SDK is still missing from this machine, so dependency install and runtime verification could not be executed yet.
