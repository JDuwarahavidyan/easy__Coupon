import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/get-started');
      // user = FirebaseAuth.instance.currentUser;
      // if (user != null) {
      //   _checkUserRole(user!.uid);
      // } else {
      //   if (mounted) {
      //     Navigator.pushReplacementNamed(context, '/get-started');
      //   }
      // }
    });
  }

  //  Future<void> _checkUserRole(String uid) async {
  //   try {
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .get();

  //     if (userDoc.exists) {
  //       String role = userDoc.get('role');
  //       if (mounted) {
  //         if (role == 'student') {
  //           Navigator.pushReplacementNamed(context, '/student');
  //         } else if (role == 'canteena') {
  //           Navigator.pushReplacementNamed(context, '/canteenA');
  //         } else if (role == 'canteenb') {
  //           Navigator.pushReplacementNamed(context, '/canteenB');
  //         }else {
  //           Navigator.pushReplacementNamed(context, '/get-started');
  //         }
  //       }
  //     } else {
  //       if (mounted) {
  //         Navigator.pushReplacementNamed(context, '/get-started');
  //       }
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       Navigator.pushReplacementNamed(context, '/get-started');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF8A00), Color(0xFFFFB400)],
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
                  Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Version 1.0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Text(
                'A Project By Team TDDS - DEIE 22',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
