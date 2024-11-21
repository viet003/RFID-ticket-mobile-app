import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize notifications
  Future<void> initNotifications() async {
    try {
      // Request notification permissions
      NotificationSettings settings = await _firebaseMessaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('Notification permissions denied');
        return;
      }

      // Fetch the FCM token
      final String? fCMToken = await _firebaseMessaging.getToken();
      if (fCMToken == null) {
        print('Failed to fetch FCM Token');
        return;
      }

      // Save the FCM token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_device', fCMToken);
      print('FCM Token saved to SharedPreferences: $fCMToken');

      // Register the top-level background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } catch (e) {
      // Handle unexpected errors
      print('Error initializing notifications: $e');
    }
  }
}

/// Top-level background message handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message:');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
