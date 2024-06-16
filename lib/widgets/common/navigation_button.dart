// navigation_button.dart
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;

  const NavigationButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
