import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  // ignore: use_super_parameters
  const BottomNavBar(
      {required this.currentIndex, required this.onTap, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        widget.onTap(index);

        switch (index) {
          case 0:
            Navigator.pushNamed(context, RouteNames.student);
            break;
          case 1:

            Navigator.pushNamed(context, RouteNames.studentReport);

            Navigator.pushNamed(context, RouteNames.report);

            break;
          case 2:
            Navigator.pushNamed(context, RouteNames.canteen);
            break;
          case 3:
            Navigator.pushNamed(context, RouteNames.settings);
            break;
        }
      },
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.6),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.doc_chart),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
