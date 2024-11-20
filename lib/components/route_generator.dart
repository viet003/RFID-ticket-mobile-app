import 'package:clientguest/screens/HomePage.dart';
import 'package:clientguest/screens/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:clientguest/screens/SignIn.dart';
import 'package:clientguest/screens/HomeScreen.dart';
import 'package:clientguest/screens/SettingsScreen.dart';
import 'package:clientguest/screens/NotificationScreen.dart';
import 'package:clientguest/screens/ProfileScreen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return buildRoute(
          SignIn(),
          settings: settings,
        );
    case Routes.home:
      return buildRoute(
        HomePage(),
        settings: settings,
      );
    case Routes.setting:
      return buildRoute(
        SettingsScreen(),
        settings: settings,
      );
    case Routes.profile:
      return buildRoute(
        ProfileScreen(),
        settings: settings,
      );
    case Routes.notification:
      return buildRoute(
        NotificationScreen(),
        settings: settings,
      );
    case Routes.payment:
      return buildRoute(
        PaymentScreen(),
        settings: settings,
      );
    // case Routes.user:
    //   return buildRoute(
    //     User(),
    //     settings: settings,
    //   );
    // case Routes.product:
    //   return buildRoute(
    //     Product(),
    //     settings: settings,
    //   );
    // case Routes.home:
    //   return buildRoute(
    //     const Home(),
    //     settings: settings,
    //   );
    // case Routes.myaccount:
    //   return buildRoute(
    //     const MyAccount(),
    //     settings: settings,
    //   );
    // case Routes.detail:
    //   final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
    //   return buildRoute(
    //     Detail(
    //       id: args['id'],
    //       name: args['name'],
    //       image: args['image'],
    //       price: args['price'],
    //       stars: args['stars'],
    //       description: args['description'],
    //     ),
    //     settings: settings,
    //   );
    // case Routes.order:
    //   final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
    //   return buildRoute(
    //     Order(
    //       userid: args['userid'],
    //       productid: args['productid'],
    //       image: args['image'],
    //       price: args['price'],
    //       count: args['count'],
    //       name: args['name'],
    //       size: args['size'],
    //     ),
    //     settings: settings,
    //   );
    // case Routes.delivery:
    //   return buildRoute(
    //     const Delivery(),
    //     settings: settings,
    //   );
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}