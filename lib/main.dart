import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/services/firebase_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization:
  // - Add google-services.json (Android) and run flutterfire configure (recommended).
  // - This call is safe even if Firebase isn't configured yet; it will show a friendly error screen.
  try {
    await Firebase.initializeApp();
    await FirebaseBootstrap.init();
  } catch (_) {
    // App still runs; features that need Firebase will show errors until configured.
  }

  runApp(const ProviderScope(child: TamilarDesamApp()));
}

