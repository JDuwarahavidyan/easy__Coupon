import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student/student_report.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteNames.reset:
        return MaterialPageRoute(builder: (_) => PasswordResetPage());
      case RouteNames.student:
        return MaterialPageRoute(builder: (_) => const StudentPage());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case RouteNames.studentReport: // Added route for StudentReport
        return MaterialPageRoute(builder: (_) => const StudentReport());

      // case RouteNames.reset:
      //   return MaterialPageRoute(builder: (_) => const CanteenPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
