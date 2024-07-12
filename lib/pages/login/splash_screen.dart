import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



// import 'dart:async';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     _controller.forward();

//     Timer(const Duration(seconds: 13), () {
//       Navigator.pushReplacementNamed(context, '/get-started');
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(


//           gradient: LinearGradient(
//             colors: [Color.fromARGB(255, 248, 248, 247), Color(0xFF1C4B82)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
          
//           // gradient: LinearGradient(
//           //   colors: [Color(0xFF1C4B82), Colors.white, Colors.white, Color(0xFFDD6B4D)],
//           //   begin: Alignment.topLeft,
//           //   end: Alignment.bottomRight,
//           //   stops: [0.01,  0.5, 0.8, 0.99],
//           ),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       return Container(
//                         width: 170 + 60 * _animation.value,
//                         height: 170 + 60 * _animation.value,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xFFDAE1E7).withOpacity(1 - _animation.value),
//                               blurRadius: 100 * _animation.value,
//                               spreadRadius: 50 * _animation.value,
//                             ),
//                           ],
//                         ),
//                         child: Image.asset(
//                           'assets/logo.png',
//                           width: 160,
//                           height: 160,
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 4),
                 
//                 ],
//               ),
//             ),
//             const Positioned(
//               bottom: 50,
//               left: 0,
//               right: 0,
//               child: Text(
//                 'A Project By DEIE 22nd Batch',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:google_fonts/google_fonts.dart'; // Import the Google Fonts package

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

    Timer(const Duration(seconds: 13), () {
      Navigator.pushReplacementNamed(context, '/get-started');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 248, 248, 247), Color.fromARGB(255, 255, 152, 34)],
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
                        width: 300 +60 * _animation.value,
                        height: 300 +60 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFDAE1E7).withOpacity(1 - _animation.value),
                              blurRadius: 100 * _animation.value,
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
                style: GoogleFonts.merriweather( // Apply the serif font style here
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
