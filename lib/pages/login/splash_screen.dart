import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Timer(const Duration(seconds: 7), _checkSession);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final int? expiryTime = prefs.getInt('expiryTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (userId != null && expiryTime != null && currentTime < expiryTime) {
      _checkUserRole(userId);
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.getStarted);
      }
    }
  }

  Future<void> _checkUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get('role');
        if (mounted) {
          if (role == 'student') {
            Navigator.pushReplacementNamed(context, RouteNames.student);
          } else if (role == 'canteena') {
            Navigator.pushReplacementNamed(context, RouteNames.canteenA);
          } else if (role == 'canteenb') {
            Navigator.pushReplacementNamed(context, RouteNames.canteenB);
          } else {
            Navigator.pushReplacementNamed(context, RouteNames.getStarted);
          }
        }
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.getStarted);
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.getStarted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 248, 248, 247),
              Color.fromARGB(255, 255, 152, 34)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: 320 + 60 * _animation.value,
                        height: 320 + 60 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFDAE1E7)
                                  .withOpacity(1 - _animation.value),
                              blurRadius: 1000 * _animation.value,
                              spreadRadius: 500 * _animation.value,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 160,
                          height: 160,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Text(
                'A Project By DEIE 22nd Batch',
                style: GoogleFonts.merriweather(
                  // Apply the serif font style here
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}