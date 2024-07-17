import 'package:easy_coupon/pages/student/student_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

class ConfirmationPage extends StatelessWidget {
  final int val;
  final String role;
  final String canteenUserId;
  final DateTime scannedTime;

  const ConfirmationPage({
    super.key,
    required this.val,
    required this.role,
    required this.canteenUserId,
    required this.scannedTime,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('yyyy-MM-dd – hh:mm a').format(scannedTime);

    // Schedule the automatic navigation after 1 minute
    Future.delayed(const Duration(minutes: 1), () {
      _navigateToStudentHomeScreen(context);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$val',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              formattedTime,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              role == 'canteena' ? 'Kalderama' : 'Hilton',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _navigateToStudentHomeScreen(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToStudentHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const StudentHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
