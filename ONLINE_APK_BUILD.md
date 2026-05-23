# Build APK “fully online” (GitHub Actions)

I can’t generate an APK directly inside this workspace because it doesn’t have Flutter/Android SDK tooling installed.  
But I **can make the build fully online** using **GitHub Actions**, which will:

- create a Flutter project on the runner
- copy this app’s `lib/`, `assets/`, `pubspec.yaml` into it
- inject `google-services.json` from GitHub Secrets
- build an **APK** and upload it as a workflow artifact

## 1) Create a GitHub repo and upload this folder
Create a new repo and upload the entire `tamilar_desam_app/` folder contents (including `.github/workflows/...` after you add it).

## 2) Add Firebase file as a GitHub Secret
1. In Firebase Console → Android app → download `google-services.json`
2. Base64 encode it:
   - Windows PowerShell:
     ```powershell
     $bytes = [System.IO.File]::ReadAllBytes("google-services.json")
     [Convert]::ToBase64String($bytes) | Set-Clipboard
     ```
3. GitHub repo → Settings → Secrets and variables → Actions → New repository secret
   - Name: `GOOGLE_SERVICES_JSON_BASE64`
   - Value: paste the base64 you copied

## 3) Run the online build
1. Go to GitHub repo → **Actions**
2. Select workflow: **Build Android APK**
3. Click **Run workflow**
4. After it finishes, download the artifact:
   - `tamilar_desam-apk` → contains `app-debug.apk`

## 4) Optional: signed Release APK (recommended later)
For Play Store / distribution, you’ll want a **signed** release build.  
Tell me if you want that and I’ll add keystore + secrets based signing steps.

