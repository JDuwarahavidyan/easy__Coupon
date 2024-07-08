import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/pages/pages.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.resetPW:
        // return MaterialPageRoute(builder: (_) => PasswordResetPage());
      case RouteNames.student:
        return MaterialPageRoute(builder: (_) => const StudentPage());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
     
      case RouteNames.qr:
        return MaterialPageRoute(builder: (_) =>  const QrPage());

      case RouteNames.report:
        return MaterialPageRoute(builder: (_) => const ReportPage());

      case RouteNames.studentReport: // Added route for StudentReport
        return MaterialPageRoute(builder: (_) => const StudentReportPage());
      case RouteNames.canteenA: // Added route for Canteen
        return MaterialPageRoute(builder: (_) => const CanteenAPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
