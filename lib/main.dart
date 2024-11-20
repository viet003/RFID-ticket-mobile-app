import 'package:clientguest/components/app_routes.dart';
import 'package:clientguest/components/route_generator.dart';
import 'package:clientguest/controller/FireBase_Api.dart';
import 'package:clientguest/screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

// void createDefaultNotificationChannel() {
//   if (Platform.isAndroid) {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'default_channel', // ID của kênh
//       'Thông báo mặc định', // Tên kênh (hiển thị cho người dùng)
//       description: 'Kênh thông báo mặc định cho ứng dụng', // Mô tả kênh
//       importance: Importance.high, // Mức độ ưu tiên
//     );
//
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
// }

void main() async {
  // Ensure that Flutter engine is initialized before using Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Firebase Notifications
  await FirebaseApi().initNotifications();
  // createDefaultNotificationChannel();
  // Run the app
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignIn(),
      initialRoute: Routes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}