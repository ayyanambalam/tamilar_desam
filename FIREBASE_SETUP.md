# Firebase Setup – தமிழர் தேசம் (Flutter)

This guide helps you enable **Phone OTP**, **Firestore**, **Storage**, and **FCM notifications** for the app.

## 1) Create Firebase project
1. Go to Firebase Console → **Add project**
2. Create project name (example): `Tamilar Desam`

## 2) Add Android app in Firebase
1. Project → **Project settings** → **Your apps** → Android → **Add app**
2. Android package name (recommended):
   - `com.tamilardesam.app`
3. Download **google-services.json**
4. Place it into your Flutter project:
   - `android/app/google-services.json`

## 3) Enable required Firebase products
### A) Authentication (Phone OTP)
1. Firebase → **Authentication** → **Sign-in method**
2. Enable **Phone**

### B) Firestore
1. Firebase → **Firestore Database**
2. Create database (start in **test mode** only for initial dev)

### C) Storage (for photo upload)
1. Firebase → **Storage**
2. Get started (rules can start in test mode for dev)

### D) Cloud Messaging (FCM)
1. Firebase → **Cloud Messaging**
2. No extra toggle needed; ensure your app is registered

## 4) Configure SHA keys (mandatory for Phone Auth on Android)
1. Get debug SHA-1 using:
   ```powershell
   cd android
   .\gradlew signingReport
   ```
2. Copy **SHA1** (and SHA-256 if available)
3. Firebase Console → Project settings → Your apps (Android) → **Add fingerprint**
4. Download a fresh `google-services.json` (recommended) and replace file.

## 5) Configure FlutterFire (recommended)
From your Flutter project root:
```powershell
dart pub global activate flutterfire_cli
flutterfire configure
```

This will generate `lib/firebase_options.dart` and wire platforms properly.

## 6) Android build.gradle wiring (if not using FlutterFire)
If you configure manually, ensure:
- `android/build.gradle` includes Google Services classpath
- `android/app/build.gradle` applies `com.google.gms.google-services`

> FlutterFire CLI usually does this automatically.

## 7) Push Notifications notes
- The app already registers `FirebaseMessaging.onBackgroundMessage(...)` in code.
- For Android 13+ you must allow notification permission on device.
- For production, create topics like `broadcast`, `district_chennai`, etc.

## 8) Suggested Firestore structure (MVP)
- `users/{uid}`: `{role: "admin"|"user", phone, district, createdAt}`
- `memberships/{memberId}`: application + status
- `surveys/{surveyId}`: raw survey records
- `news/{newsId}`: posts
- `events/{eventId}`: event data + registrations subcollection
- `notifications/{id}`: optional in-app notification feed

## 9) Security Rules (important)
For MVP dev, you can start with test rules, but before production you must:
- Restrict writes to authenticated users
- Allow admin-only writes for news/events/approvals
- Avoid storing Aadhaar unless truly required; if stored, encrypt + restrict access tightly

