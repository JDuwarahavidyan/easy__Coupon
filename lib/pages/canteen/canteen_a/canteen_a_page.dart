import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/pages/canteen/canteen_a/canteen_a_report.dart';
import 'package:easy_coupon/pages/canteen/canteen_a/canteen_a_home.dart';
import 'package:easy_coupon/pages/canteen/canteen_a/settings_page.dart';

import 'package:easy_coupon/repositories/user/user_repository.dart';
import 'package:easy_coupon/services/user/user_service.dart';
import 'package:flutter/material.dart';


class CanteenAHomeScreen extends StatefulWidget {
  const CanteenAHomeScreen({super.key});

  @override
  State<CanteenAHomeScreen> createState() => _CanteenAHomeScreenState();
}

class _CanteenAHomeScreenState extends State<CanteenAHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(UserRepository(UserService()))..add(UserReadEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            // Navigate to the login page
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Student Home Page'),
          // ),
          body: IndexedStack(
            index: _selectedIndex,
            children:const <Widget>  [
              CanteenAHomePage(), // Home Page
              CanteenAReportPage(), // Report Page
              SettingsPage(), // Settings Page
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
