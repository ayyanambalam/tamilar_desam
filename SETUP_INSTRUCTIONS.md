# Setup instructions (Windows)

Because Flutter SDK isn’t installed in this environment, this deliverable contains the **complete app source (lib + assets + pubspec)**.  
To make it a runnable Android app on your machine, follow the steps below.

## A) Create a Flutter project
1. Install Flutter (stable) from: https://flutter.dev/docs/get-started/install
2. Open PowerShell in a folder where you want the project and run:
   ```powershell
   flutter create tamilar_desam_app
   ```
3. Copy these items from this deliverable into that new project (overwrite when asked):
   - `pubspec.yaml`
   - `analysis_options.yaml`
   - `assets/`
   - `lib/`

Then run:
```powershell
flutter pub get
flutter run
```

## B) Firebase setup (required for OTP/FCM/Storage/Firestore)
1. Create Firebase project
2. Add Android app (package suggestion: `com.tamilardesam.app`)
3. Download `google-services.json` → place at `android/app/google-services.json`
4. Enable:
   - Authentication → Phone
   - Firestore Database
   - Storage
   - Cloud Messaging
5. (Recommended) Configure via FlutterFire:
   ```powershell
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

## C) Production hardening checklist (for “election-ready”)
- Firestore Security Rules for admin role writes
- Cloud Functions for:
  - Membership approval workflow
  - Survey aggregation (district reports)
  - Donation receipt generation & payment verification
- Privacy: handle Aadhaar carefully; store only if necessary; encrypt at rest
- Crashlytics + Analytics + Remote Config for campaign banners

