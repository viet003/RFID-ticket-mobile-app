import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize notifications
  Future<void> initNotifications() async {
    // Request notification permissions
    await _firebaseMessaging.requestPermission();

    // Fetch the FCM token
    final String? fCMToken = await _firebaseMessaging.getToken();

    // Print the FCM token to the console
    print('FCM Token: $fCMToken');

    // Register the top-level background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

/// Top-level background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message:');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
