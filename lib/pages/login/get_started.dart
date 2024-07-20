import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../routes/route_names.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: LoginWidget(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 45.0),
                    child: const Text(
                      'WELCOME !',
                      style: TextStyle(
                        fontSize: 40.0,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 97, 96, 94),
                          ),
                        ],
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'Get Your Food Easy and Fast',
                    style: TextStyle(
                      fontSize: 16.0,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                          color: Color.fromARGB(255, 97, 96, 94),
                        ),
                      ],
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SlideAction(
                      onSubmit: () {
                        _navigateToLogin(context);
                        _animationController.reset();
                        return null;
                      },
                      text: 'Get Started',
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      outerColor: Colors.white,
                      innerColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
