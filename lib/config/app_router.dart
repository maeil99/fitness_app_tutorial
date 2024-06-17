import 'package:fitness_app_tutorial/screen/auth/view/login_screen.dart';
import 'package:fitness_app_tutorial/screen/home/view/home.dart';
import 'package:fitness_app_tutorial/utils/constant/path_route.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PathRoute.homeScreen:
        return _generatePageRoute(settings, (_) => const Home());
      case PathRoute.loginScreen:
        return _generatePageRoute(settings, (_) => const LoginScreen());
      default:
        return _generatePageRoute(
          settings,
          (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _generatePageRoute(
    RouteSettings settings,
    Widget Function(BuildContext context) builder,
  ) =>
      MaterialPageRoute(builder: builder, settings: settings);
}
