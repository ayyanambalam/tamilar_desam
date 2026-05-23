# தமிழர் தேசம் (Tamilar Desam) – Flutter + Firebase App

This is a **modern Tamil-first political campaign** app scaffold for the party **“தமிழர் தேசம்”** with:

- Full Tamil UI support (Material 3 + `flutter_localizations`)
- Campaign dashboard (banners, leader message, news, events, announcements)
- Membership registration (photo upload, membership ID, QR, **PDF card**)
- Survey module (caste/voter survey + analytics charts + export)
- Donations (UPI intent + QR) and social sharing
- Firebase: Phone OTP auth, Firestore/Storage, FCM push notifications
- Offline-ready caching using Hive + sync pattern (starter implementation)

## 1) Prerequisites (on your machine)
- Install Flutter SDK (stable)
- Android Studio / Android SDK
- Firebase project (Android app registered)

## 2) Firebase setup (required)
1. Create a Firebase project
2. Add an Android app (package name suggestion: `com.tamilardesam.app`)
3. Download `google-services.json` and place it at:
   - `android/app/google-services.json`
4. Enable:
   - **Authentication → Phone**
   - **Firestore Database**
   - **Storage**
   - **Cloud Messaging (FCM)**

> This repo includes code stubs and schema suggestions; you’ll still need to run `flutterfire configure` (recommended) or add Firebase files manually.

## 3) Run
```bash
flutter pub get
flutter run
```

## 4) Firestore collections (suggested)
- `users/{uid}` → profile + roles
- `leaders/{leaderId}` → leader directory
- `news/{newsId}` → posts
- `events/{eventId}` → event posts/registrations
- `memberships/{memberId}` → membership applications & issued cards
- `surveys/{surveyId}` → raw survey submissions
- `donations/{donationId}` → donation logs (client-side capture; payment verification server recommended)
- `booths/{boothId}` → booth management
- `volunteers/{volunteerId}` → tracking & attendance

## 5) Admin panel
You selected **“Firebase Console only”** for the admin panel.  
This scaffold uses **roles in Firestore** to gate admin-only screens inside the app.

## 6) Branding & theme
- Yellow: `#FFD600`
- Pink: `#E91E63`
- White background
- Glassmorphism cards + rounded corners + gradients

## 7) Notes
- Payments: for real production donation receipts, use a server to verify UPI payment status.
- OTP: on Android, Phone Auth requires SHA-1/SHA-256 configured in Firebase.

