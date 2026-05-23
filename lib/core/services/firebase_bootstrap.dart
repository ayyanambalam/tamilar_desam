import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// FCM background handler (required for receiving messages when app is terminated).
/// NOTE: This requires Firebase to be configured in the Flutter project (google-services.json etc).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Ignore until Firebase is configured.
  }
}

class FirebaseBootstrap {
  static Future<void> init() async {
    // Ask notification permission (Android 13+ / iOS).
    await FirebaseMessaging.instance.requestPermission();

    // Ensure token is generated early.
    await FirebaseMessaging.instance.getToken();

    // Background handler for FCM.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Optional: subscribe everyone to a topic like "broadcast" for campaign-wide messages.
    // await FirebaseMessaging.instance.subscribeToTopic('broadcast');
  }
}
