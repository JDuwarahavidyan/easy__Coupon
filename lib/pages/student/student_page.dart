import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/repositories/user/user_repository.dart';
import 'package:easy_coupon/services/user/user_service.dart';
import 'package:flutter/material.dart';


class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
              StudentPage(), // Home Page
              StudentReportPage(), // Report Page
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
