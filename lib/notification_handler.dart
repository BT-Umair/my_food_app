import 'package:firebase_messaging/firebase_messaging.dart';

// IMPORTANT: Yeh background handler hamesha class ke BAHAR (Top-level) hona chahiye.
// Jab app BAND hoga ya BACKGROUND mein hoga, toh yeh function automatically execute hoga.
Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  print("App band tha tab notification aayi: ${message.notification?.title}");
}

class NotificationHandler {
  // Firebase Messaging ka ek instance (object) banayein.
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initializeSettings() async {
    // 1. User se notification dikhane ki permission mangein.
    NotificationSettings settings = await _messaging.requestPermission(alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User ne notification permission de di hai! ');
    } else {
      print('User ne permission reject kar di hai! ');
    }

    // 2. Apne device ka unique FCM Token nikalyein.
    String? token = await _messaging.getToken();
    print("YOUR FCM TOKEN ");
    print(token);

    // 3. Jab app screen par KHULI HUI HO (Foreground), tab notification listen karein.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("App khuli hui hai aur notification aayi: ${message.notification?.title}");
      // Yahan hum aage chalkar custom pop-up banner banana seekhenge.
    });

    // 4. BACKGROUND / KILLED: Jab app background mein ho ya poora band ho (Same for all apps).
    FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

    // 5. CLICK ACTION: Jab user notification par CLICK karke app khole (Same for all apps).
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User ne notification par tap/click kiya: ${message.notification?.title}");
      // Yahan se aap user ko specific screen par bhej sakte hain
    });
  }
}
